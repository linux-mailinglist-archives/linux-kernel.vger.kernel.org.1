Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214702BB5AD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgKTTkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgKTTki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:40:38 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D11AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:40:37 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id a18so8856687pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcvJ2XThRkU1T/Rs2Tzb2h0oaIYPc8Jt02INLZSSIdg=;
        b=lS2ELTIvmbqPzk07btq+ZwW9SZclh1wNAxgweJU2jviIUiM0s5kXY8ep1C8QCEIj3A
         URf8jlFtW4BDaZ2AE/SXVAB8A6gJJwKYqbm14BmVw9QKCn8NmfDMocNNr4/7DKXQqY3+
         VZU9emWSnXkAh5YohstQaiOlfFoX8NIaDRll8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcvJ2XThRkU1T/Rs2Tzb2h0oaIYPc8Jt02INLZSSIdg=;
        b=q9hjiuh6if4KH6ZkJe+jE9XtTxzwV5H0b2jh1oc7Dl01fcAnRZ/GAy4sqxXyJI1fzh
         nMmQSuYntX7WBV4X3I9D8hcOIl0V/XdKRSDz9QL4kaZWCHCtb7+l62iEdsZm8v3SkbuD
         cKZ5Dxac/CFi7ZO/jUstlC0G4rZCE8rKZn8KSEpFPqdTw6xZ4uheaxtToS8Wu0TGEtxV
         F/oQZz65ZvkVyk4ylwcEr3IXL8vphMJCX5QBMGJEq3JQ1033P4o6qiQAa8KFQVU0irfK
         UJWWTJKiyJLi6+Rbtru8BZlRkpNNxFB9uLnlw7POVwYMw4fvSLgf+Zg6mrv0CDq6Bmcr
         Y/kQ==
X-Gm-Message-State: AOAM532lXOeZp0JqrVIjpEim/eBqKXZEqbVMzNPeUmYU2J4vdBhqZTNF
        fRtbtgoPv2au2EAHUlC7YvPKsg==
X-Google-Smtp-Source: ABdhPJzsL2HjCKvxvxJU6euM9l1W0EorOD29H8JdRDv/MxYx6lxiMQ5OgA5y9MhkUFwRP4+Gm2y2GQ==
X-Received: by 2002:a17:90a:2e10:: with SMTP id q16mr12245805pjd.183.1605901236641;
        Fri, 20 Nov 2020 11:40:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h16sm4156625pgd.62.2020.11.20.11.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:40:35 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Tyler Hicks <code@tyhicks.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2] seccomp: Remove bogus __user annotations
Date:   Fri, 20 Nov 2020 11:40:24 -0800
Message-Id: <160590121736.3376343.9881262449141772131.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120170545.1419332-1-jannh@google.com>
References: <20201120170545.1419332-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 18:05:45 +0100, Jann Horn wrote:
> Buffers that are passed to read_actions_logged() and write_actions_logged()
> are in kernel memory; the sysctl core takes care of copying from/to
> userspace.

Applied to for-next/seccomp, thanks!

[1/1] seccomp: Remove bogus __user annotations
      https://git.kernel.org/kees/c/fab686eb0307

-- 
Kees Cook

