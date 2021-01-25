Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22123036D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389157AbhAZGwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbhAYPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:35:40 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8CC061220
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:20:52 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id v126so12730916qkd.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GjyXRdkS9rYBkV7uCNLwkePmU3ilYmeFcWLWpttgYjU=;
        b=stEDK4sk0hGJhirBVI5jQ0Wtp9k0V7TJzrUFNqqxpOlgxQgIID1zxEJ1RmKBelzaYa
         fHWsD6UBuRDGvoBIc7Hfq0mVGO4lUxc+4M2v5YiDxMSjIhf5fnRwelOrC352FWNZ4Slh
         Sn3/jOV0QduzaPpI6Sk4OG4E6+QrpXxtEHgkpgENKQ4g2bE1A0y9BVM3fkYSc7c6gdpq
         i/ZQGwXWc5fd1id5h4Hc7heHZdch72cMxps4Bx1ewiI20ffZ/1Jo7x+/VG5aqQreVjBx
         7OApyL4WgLIA0I9XqpWiDHetDaA0H19sO/qu+VbB4pK5Pe/mQTv0YOBDm9g4SY1/GVO7
         gLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GjyXRdkS9rYBkV7uCNLwkePmU3ilYmeFcWLWpttgYjU=;
        b=XPpMrXnBXFBKPEn8262ysbZ0exjVjf2RYP8OZep9PJ06ZRg426PBhpPKYdlBDQIYjj
         EvnpRB1xlyL4rpIZlhUIiJ3ydqu3ZQ41uZQUGv1cSa+ObkQmPfIObXfZfqLH8o57fYqT
         wC2TFIJfOtBjX9FP0l6t7jzAMzPGLb+cdaxU2k8qUnoQGQcCLHf63kdkyXTKiNb3IVpF
         gJwmzSEImc3VqpUWo569FkUBm+URN0vYEmn7EOrdlHVkh9bw7of4pgaGrPntARDHkWNj
         D7/XFBx/EOBxcL6zdJBeowDteTg75NWamdPTPbt9J08Sq8gwqXk07DQaHOafflyFUQX+
         bL6A==
X-Gm-Message-State: AOAM533Ib7zqf5HWuz+XYNVeBgBQLSZakGkpubkvtk+La05vJo/wvGax
        8JR5uNZUcUX5tzeEFoosbC0=
X-Google-Smtp-Source: ABdhPJw2FEHmPYPDqiG5RwW2W6SL4HC17iaQM2x+z+j/T2np7lIWVdUbIWgDclrrVTBEJSJ1rpMfXQ==
X-Received: by 2002:a37:8942:: with SMTP id l63mr1210058qkd.94.1611588051712;
        Mon, 25 Jan 2021 07:20:51 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id b16sm11126295qtx.85.2021.01.25.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:20:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Jan 2021 10:20:52 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, walken@google.com, dave@stgolabs.net,
        mingo@kernel.org, tglx@linutronix.de, oleg@redhat.com,
        irogers@google.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v2 4/7] rbtree, perf: Use new rbtree helpers
Message-ID: <YA7h1OZOoOna+e4G@slm.duckdns.org>
References: <20210125150953.679129361@infradead.org>
 <20210125151314.808569647@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125151314.808569647@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 04:09:57PM +0100, Peter Zijlstra wrote:
> Reduce rbtree boiler plate by using the new helpers.
> 
> One noteworthy change is unification of the various (partial) compare
> functions. We construct a subtree match by forcing the sub-order to
> always match, see __group_cmp().
> 
> Due to 'const' we had to touch cgroup_id().
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
