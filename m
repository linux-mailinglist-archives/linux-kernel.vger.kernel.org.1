Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3672929A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgJSOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgJSOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:41:20 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489A0C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:41:20 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j17so346833ilr.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=THXhNn3N0VKH4bbT8YLaj2E7MAt4tehXfuclzUKK6x8=;
        b=SRWxn73+ZWx3dfEdyQXR87WIMFt7s3Hk9l3VgaX2qkdUIAU9zlv+HWYeqARbUbvQjW
         5GbSNrn5qKzQcLmlRqjpBpw0L65Tx7oZNfJr0lIaQ2on9shuvchuHBkB1iEEqSFpjyTf
         QRD0HNRKYu0WnDvw9despvsBFp7yN+7zYaVzMGY94/U9zjDQMJy2gG5Ed0NvPAfDajJJ
         S1XvmOWW7lU6XUC8JueFC3qc4eHOGDHRqk9cXtVz1949JFkS/6cP4dwL9ua1l0nacQIq
         CPygKyYY4KKabWBzLHZiCkNpF95GgWS5FNTF51cpxjw5AWUeOr+iqyHChNLswvFYlDRt
         L4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=THXhNn3N0VKH4bbT8YLaj2E7MAt4tehXfuclzUKK6x8=;
        b=Hwm0Zi1JB45/d7TqMXnicZpkOGf5vSFeC1E6aMK1JZ8ouUYk9OghehQ25s/tLN3lH2
         0V8cS6/tinnjjPdUr+lRP0FC2xfC3LJSiyFsUpnJmaM6EQueuj1yeW+xOprrqJ/fE4jW
         m+Xz9kkGSwZN/zWJfRjHrDAaHPXX/hSZjV0vQmMnOxPA3Lko3N+t4K5pQDbHjya1CU00
         joctiT2i8OLlAp9yBDKJ44nVru6IavFRu1FbKHTqKs3g18YdFSHzDjcbvFZP1OQORccH
         ZliJBA+ukXspfiIu2/P/9ZO9T7Y1YbZaD5rvQCCrZ9thQ2arwzkZdk6aOI8Fkq7SbkyB
         U4qw==
X-Gm-Message-State: AOAM531/SQtcUvf3J8Tcgx63its0Fpd2omBOnnrqNav4q+jcZuglaZFV
        1KnIYBKRYBfiyIE9v+WRZ/4=
X-Google-Smtp-Source: ABdhPJxmqjq//UUtBWN15n4kJbFayWvYHh/62WYgZRtdSeJGXa/cDLkIqbGWhY1+vZFvW/mV16BS+Q==
X-Received: by 2002:a92:cb4e:: with SMTP id f14mr214431ilq.122.1603118479419;
        Mon, 19 Oct 2020 07:41:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b34d])
        by smtp.gmail.com with ESMTPSA id z15sm11221922ioj.22.2020.10.19.07.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:41:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 19 Oct 2020 10:41:17 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH] kernfs: bring names in comments in line with code
Message-ID: <20201019144117.GA4418@mtj.thefacebook.com>
References: <20201015185726.1386868-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015185726.1386868-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 02:57:26PM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Fix two stragglers in the comments of the below rename operation.
> 
> Fixes: adc5e8b58f48 ("kernfs: drop s_ prefix from kernfs_node members")
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
