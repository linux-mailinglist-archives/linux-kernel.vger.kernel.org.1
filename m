Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C8628428A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 00:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgJEWcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 18:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbgJEWcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 18:32:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC7C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 15:32:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d6so232332plo.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qMW+aSE29mfc0dpFg0kQzfT3L9pQ5NkimhwaHnFfZs=;
        b=D1tSC+bumb62FgIGuo+8IB6KKGvW+KNTkWvAdSYY2bRIgEq9C6S+Z88icDO1jVROY5
         n3yUAhc2SyGGCNaXTN6Wdf0jb9giw3GvZunM3yF7hSg2h8WjkjjigyBynFZKlcbw91VJ
         umb88IgY2RRQJQ89lS+ajaXOsC/+8/NtDUE/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qMW+aSE29mfc0dpFg0kQzfT3L9pQ5NkimhwaHnFfZs=;
        b=mM/lJfrgqGVa4rXAilVjwXk9rPjQpbdKVuCF7Vk2iX40q8R5wP9tin0pZE2a5PoUAD
         XH0XEuoJZA4lPXq62gxfpZy3+Gy+DTed6nM7Otj7hiJce8A8RSxi/nG2jKe5ZZRLzLJg
         s4fQyPzhnjcW6H1Usk3zJVVE6KOPm7/PaZSAtlnIEpwccQIYyDzkIklFlSewv0khMmor
         GxNyeV5wjroc3TDqyvjaohqyA5SwTugFESTFONaU6/ttOf4sEDeuuuXOsYnk0/TS6wzx
         5ucdkWq5GdqkcuF0qXCev75WFS8RxdzE9J0NxngeyAhspk7cf8WLpk+tVre3bZkz2hCu
         FvKA==
X-Gm-Message-State: AOAM530IM3Jd357nH168IxrocKBCuYE4bhfma7AeiEqQxkGeUwO6ONKT
        S/8rKYx1YcJfgLKgTUOCUJmFkg==
X-Google-Smtp-Source: ABdhPJwwpxHZjbDiRNiSwr9DTv3L1UTxRsObme+bs9Tfb+P06XarACrEbQKo1i6IJJSR6rcMe+2zFw==
X-Received: by 2002:a17:90a:d905:: with SMTP id c5mr1521662pjv.24.1601937159034;
        Mon, 05 Oct 2020 15:32:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3sm940040pff.71.2020.10.05.15.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 15:32:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH resend] seccomp: Make duplicate listener detection non-racy
Date:   Mon,  5 Oct 2020 15:30:54 -0700
Message-Id: <160193704489.2698420.14892403272288554518.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201005014401.490175-1-jannh@google.com>
References: <20201005014401.490175-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 03:44:01 +0200, Jann Horn wrote:
> Currently, init_listener() tries to prevent adding a filter with
> SECCOMP_FILTER_FLAG_NEW_LISTENER if one of the existing filters already
> has a listener. However, this check happens without holding any lock that
> would prevent another thread from concurrently installing a new filter
> (potentially with a listener) on top of the ones we already have.
> 
> Theoretically, this is also a data race: The plain load from
> current->seccomp.filter can race with concurrent writes to the same
> location.
> 
> [...]

Applied, thanks!

I added the stable CC, but I'd agree: it's not so urgent that I need to
get this into Linus's tree ahead of the regular merge window. :)

[1/1] seccomp: Make duplicate listener detection non-racy
      https://git.kernel.org/kees/c/ed2d479d3335

-- 
Kees Cook

