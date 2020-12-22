Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E632E08AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 11:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgLVKVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 05:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLVKVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 05:21:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52103C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 02:20:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g185so1643950wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 02:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Fero/xKzEjFCEIalowNmvB1sMONhhEmpACCnhnnKuUs=;
        b=dboFykjQ/iwbjXNbRv2V2ZcYWqW3BZXTBuj3osnuveC6ZCydo/S4ByuwUd47XyMYu3
         uF3Jno24Ndy1fwwLWiN5H5iwo7+NfK7TZe1xctiuTx9UAN2T33IAg0QWhUtT35ZJxCmU
         4hhfyJQA4jNVUR5lP3iFLRdl1ewUzaJStj5YxriETcvznbVb1/SarFhhaV8obEtWs6ev
         xMmAa02TUgxnHAI4Wnr8CHRl07oTzu2+i4AihTbhFrBoDcsqzQR7RDS/+DFLoY2EH2eA
         BiMMebSkEZ3k4z+be1Bk7fzK17NUIm6AjkXrAJwOiZeD70ji/WmtkyyRg49+DQ+Jq5+Y
         KNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Fero/xKzEjFCEIalowNmvB1sMONhhEmpACCnhnnKuUs=;
        b=tXMcv+LFjPWGMy0GusAifuVZL42tTGPa3HlO4C/J/bMjZIsIBaN7/IYInSdOy7dz9s
         Ce5wZ0nzc5uk9OhaQvoyX9hlKZ3y6weV481FSpkrgirYxA10idPgc2J/FmwXvShExqIf
         t8vTfefX9KWC+0egbJ2jvQLzPKA8cPezREV6WOO03hgQ4/ZZrMdZBF1SSWPp3Hir45f0
         z41grI4KevAbDQkKv+r0B4XdQWpJ9Wbg++31EP2nJQ3pEfWrAhoIihrMxhEX5b8DdYKM
         7IruRDf+aQz3zt9QtfR5Vjezuq+KW7UNB3CBy6+tumUD6T8Uob+Sy3Cj1d0IYJrBeP3w
         V5YQ==
X-Gm-Message-State: AOAM532qmeGmIeNH+rySyvMsf522DvXwhC4MEI5j7yC/pYUaaClrzyhx
        RAiXJg6ccDKks3+eaFimGfz8aGOHzzEdkg==
X-Google-Smtp-Source: ABdhPJxYiWxYrqUIemGmokP2k8c5wxQmahDGGW4EqMork1NnqtF3kwkvbAFAdLfNkDQnelU0+Fi4AQ==
X-Received: by 2002:a1c:454:: with SMTP id 81mr21053865wme.178.1608632430958;
        Tue, 22 Dec 2020 02:20:30 -0800 (PST)
Received: from ?IPv6:2001:a61:2467:2f01:faca:3d43:5e40:30d1? ([2001:a61:2467:2f01:faca:3d43:5e40:30d1])
        by smtp.gmail.com with ESMTPSA id z6sm31757012wrw.58.2020.12.22.02.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 02:20:30 -0800 (PST)
Cc:     mtk.manpages@gmail.com, Alejandro Colomar <alx.manpages@gmail.com>
To:     lkml <linux-kernel@vger.kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.10 is released
Message-ID: <5484fef4-0502-9366-1a59-c26dc742c785@gmail.com>
Date:   Tue, 22 Dec 2020 11:20:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

For this release, Alejandro (Alex) Colomar has joined me
as a comaintainer and we are proud to announce:

    man-pages-5.10 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from around 25 contributors. The release includes 
just over 150 commits that changed around 140 pages.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.10

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2020/12/man-pages-510-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-5.10 ====================


Newly documented interfaces in existing pages
---------------------------------------------

access.2
    Michael Kerrisk
        Document faccessat2()
            faccessat2() was added in Linux 5.8 and enables a fix to
            longstanding bugs in the faccessat() wrapper function.

membarrier.2
    Peter Oskolkov  [Alejandro Colomar]
        Update for Linux 5.10
            Linux kernel commit 2a36ab717e8fe678d98f81c14a0b124712719840
            (part of 5.10 release) changed sys_membarrier prototype/parameters
            and added two new commands [MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
            and MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ].

mount.2
statfs.2
    Ross Zwisler
        Add NOSYMFOLLOW flags to mount(2) and statfs(2)


Changes to individual pages
---------------------------

cacheflush.2
    Alejandro Colomar
        Document Architecture-specific variants
    Alejandro Colomar  [Heinrich Schuchardt]
        Document __builtin___clear_cache() as a more portable alternative

clone.2
sigaltstack.2
    Michael Kerrisk
        clone(CLONE_VM) disables the alternate signal stack

mmap.2
    Michael Kerrisk
        Clarify SIGBUS text and treatment of partial page at end of a mapping

perf_event_open.2
    Namhyung Kim  [Alejandro Colomar]
        Update man page with recent kernel changes

sigaltstack.2
    Michael Kerrisk
        Clarify that the alternate signal stack is per-thread

timer_getoverrun.2
    Michael Kerrisk
        timer_getoverrun() now clamps the overrun count to DELAYTIMER_MAX
            See https://bugzilla.kernel.org/show_bug.cgi?id=12665.

uselib.2
posix_memalign.3
profil.3
rtime.3
    Michael Kerrisk
        Remove some text about libc/libc5
            With this change, there remain almost no vestiges of information
            about the long defunct Linux libc.

signal.7
    Michael Kerrisk  [Heinrich Schuchardt, Dave Martin]
        Add some details on the execution of signal handlers
            Add a "big picture" of what happens when a signal handler
            is invoked.

tcp.7
    Alejandro Colomar  [Philip Rowlands]
        tcp_syncookies: It is now an integer [0, 2]
            Since Linux kernel 3.12, tcp_syncookies can have the value 2,
            which sends out cookies unconditionally.

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
