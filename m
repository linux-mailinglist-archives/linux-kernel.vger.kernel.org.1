Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D2D261F63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbgIHUCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbgIHUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:02:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA19C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 13:02:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v196so199422pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+Aniqm426lptxXBdTzT7j62mGC/+JOEvzDp+hYSZVE=;
        b=Q+Q2YAWKZWzPyO2iLJ6cCUDcS76R8NyoRA/UeDzkGVM8aeee0koguncinCMH0wyH/m
         e7/X+wiDsS2IXv+P4RvgdRcnrfuQ9ScLSwWyYC+LdQ3Yd3fqbP2WaokF07yqvmuIe0R+
         0oSdXCiGrNzQwKyxEmage7UCpoRwQHF5c35ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+Aniqm426lptxXBdTzT7j62mGC/+JOEvzDp+hYSZVE=;
        b=bpkk/SOLRYfo3jUn19ImkZc9tc4pZKyI3sFKGsbn6gjfZ+e2qyK8l7LbmBLPOYPZVF
         PltbKjjSOT7W++aN3B/9b/FP6M5+waSQngo5qgav8hV5KTqwar9PnEZx9GpvU+Fu2dkb
         nBAg/TCGkGzrJL8gi6uEGXLaLXj3ZqLNli5mxFpD2XPsxWlpbuNF223jB1p7+syRzulv
         sciLpdmPYXOu++OjsbAupBQs1XAse4i7ooLxWi51H65Npk4yTH8d3ZIWXJaGdyQgOTe+
         GZcCQ/KZB1Y6hlfIeZIlXqJB0cqzu2+MnCRu//l1l1TkE1hl8xbgaKqJGUiK+rFaiO0m
         c/Rg==
X-Gm-Message-State: AOAM5333edw7sHCMV2jVftLopS5KdKi82NyDmmw2AjYVCFBhEmzqr/6S
        st7HMKyemxRfx5rHwtqSsSjh3OnJmKh+dQ==
X-Google-Smtp-Source: ABdhPJz1I8wNlxKiQFz0VaDXKp+YILhPFrtyD7bamTcFRsHJyBCdLG0VhnerUTLpnN3/fQZBOmGY1A==
X-Received: by 2002:a63:4f66:: with SMTP id p38mr304001pgl.284.1599595350176;
        Tue, 08 Sep 2020 13:02:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm240221pfk.118.2020.09.08.13.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:02:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] seccomp: Use current_pt_regs()
Date:   Tue,  8 Sep 2020 13:01:00 -0700
Message-Id: <159959525269.1676241.9638891402851121567.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824125921.488311-1-efremov@linux.com>
References: <20200824125921.488311-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 15:59:21 +0300, Denis Efremov wrote:
> Modify seccomp_do_user_notification(), __seccomp_filter(),
> __secure_computing() to use current_pt_regs().

Applied, thanks!

[1/1] seccomp: Use current_pt_regs() instead of task_pt_regs(current)
      https://git.kernel.org/kees/c/4484dbacd7b6

I reworded your commit based on the thread and added one comment for
a weird case where task == current, hopefully that looks correct:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/seccomp&id=4484dbacd7b61eaa4e21332c0a044dedce732ebb

-- 
Kees Cook

