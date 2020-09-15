Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37726B3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgIOXGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgIOOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:47:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AFBC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:47:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z1so3659942wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cKAuQhWs55mLBj+yTqCFIZAuhJlnmwI9/apcg/+PbDc=;
        b=sqw2uVzKl39Rp/DohWXj1JdHI3U0D5LfEIprxEMwYEDUSoAOY66vrYDnP6bPY9ooLO
         igrVV/5um3SC6pDyPgzni6tsLBfCFdAc4O2z2i+iX6sCDGr2Ty2Jx3M/5DC0IS/wPmAG
         uV3JPS+0Rx4zd+N+115Kw9JHeWPOFgu4YFdDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cKAuQhWs55mLBj+yTqCFIZAuhJlnmwI9/apcg/+PbDc=;
        b=njIM6L5vwJlpBqzrH0FHXmlOdsrcjBNwp0IELcHOM+lxivWmkiHSPIjueniKLyd0Gr
         M9jDZxco9AFKXd8h5lqX3IIAbMPajOxdTg/YM7BAjNXDs2vP9Pgd0ADoGP1lWxG0SG+a
         FLUtpICBFGekl62sCKNqiVJubk/hiA/goGB/uAKEumkeeionfdPF1iRxJG0Ko+JawlhO
         cJW/9Xw44MP0SqWfR+nH8r6jNTFovqd+JatTBQ1YFaskYLKkm5dZMy2V4N9n/Y06d/IX
         OU3jUS0Cq5+4RQj72NQXTFt5A0cXTTTMOS/dYRdY4Y9VdkLxmqcw+59qTdEkzwr4+duW
         TS5w==
X-Gm-Message-State: AOAM531SpIg5ukl82KMxlL5s21TFz2xiMmeIuT6qaxgvNuXot5l0J4E/
        TCrr3tj76FnfYPz87fC0FOgj5Q==
X-Google-Smtp-Source: ABdhPJxN657HDjZAFsjqwhpo2PgigYN+fDDRRd0Guh0rR8Zkjn8q2yNDAvekj0uIPaKZLFcZfre8FQ==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr21486458wrg.11.1600181258598;
        Tue, 15 Sep 2020 07:47:38 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id c18sm29223198wrx.63.2020.09.15.07.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 07:47:38 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:47:37 +0100
From:   Chris Down <chris@chrisdown.name>
To:     zangchunxin@bytedance.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4] mm/vmscan: add a fatal signals check in drop_slab_node
Message-ID: <20200915144737.GA2581123@chrisdown.name>
References: <20200915132741.84869-1-zangchunxin@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200915132741.84869-1-zangchunxin@bytedance.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zangchunxin@bytedance.com writes:
>+		if (signal_pending(current))
>+			return;

This doesn't match your patch title, please update it. :-)

After that, you can add:

Acked-by: Chris Down <chris@chrisdown.name>
