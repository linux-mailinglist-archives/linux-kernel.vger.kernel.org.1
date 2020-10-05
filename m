Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947D5283CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgJEQjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgJEQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:39:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B8C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:39:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so2462389pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bgKuiZru+fzYOW+rknHpx1Qb/5rCkL8zdBgqBiopZMo=;
        b=l6LKrMfjBVohHwxF9jv9cqtVCwnHkEr5vlQIuvPbeEgaOLBzDUY+wRtP25s/t70Hhk
         5kWV73hIpokOwi1l3tHFPB2vRCReQJOQ4ip2SfbDgwGkEVVTeChIsI38ZzqFLsIBYJ54
         Co2LtOtfJKXU4ezUVwnCkRZlXHoLRNgYZANjYnRB2g2PAYqQGWe+iLcKStDvNMwo9wl4
         2IEPUjd/4a30CwRyaXqR5Y/7BZTsWDS/rqJ5l9ENklSFMXLNAF4CIFlDSZ3Q4xVN9M0O
         H3omOE7p1NxvhbLbxwFC1f0wKnxwTlqnG1HOfQuubft5h5kKaYf0aCI7hgPx+yG0l8YJ
         X32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bgKuiZru+fzYOW+rknHpx1Qb/5rCkL8zdBgqBiopZMo=;
        b=b/C8GsxcW4iGboJnNJmy74iAudproIsR0P2KnWM1rnJsnIC2IKroetiOgEmyEfFrPD
         vny1pwUioAtGI9N7elx+4b+yt9GDlpB6/ydbj89oy/xHCgxIrz/1ILwN6w9dYMU3kmgl
         TjSf8yeg/uRb3WzpPk78iB2z84zGWhdVjn2NYySKX+niaye1qTBlH2HFDhen4aumd62l
         OSws4jhRHoJZX0Dx8b7vLzxGfO131HwrovZB3IWxOWgef10hugPfmvlRaE0dHHIAhIR/
         I9JBpRRSeLlhN64fwf48n/Z+mWJWURwPgXucJ59sAA62NLnay8ZdO0Zu3IQxIWUq/v+L
         fl4Q==
X-Gm-Message-State: AOAM531tDU6haBFknikjrAwW6F/xaS/+gBA4sfh862GSW1i20OOV59bT
        9czptCjU/Lqc2hNkBba1jJ2TFg==
X-Google-Smtp-Source: ABdhPJzscDCmybkxTYMeNPHRJvgED0ZxQ648JzxM13dAod0j3fjEo4NfbnuwNAzcN1JII0PYa0oCnw==
X-Received: by 2002:a05:6a00:1356:b029:13e:5203:fba3 with SMTP id k22-20020a056a001356b029013e5203fba3mr565585pfu.3.1601915992319;
        Mon, 05 Oct 2020 09:39:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z9sm418686pfk.118.2020.10.05.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:39:51 -0700 (PDT)
Date:   Mon, 05 Oct 2020 09:39:51 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Oct 2020 09:39:45 PDT (-0700)
Subject:     Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
In-Reply-To: <87lfglt6z1.fsf@igel.home>
CC:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, tycho@tycho.ws,
        nickhu@andestech.com, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-847e71cf-64bc-464b-8d09-3bcec40aa491@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Oct 2020 01:25:22 PDT (-0700), schwab@linux-m68k.org wrote:
> On Sep 14 2020, Aurelien Jarno wrote:
>
>> How should we proceed to get that fixed in time for 5.9? For the older
>> branches where it has been backported (so far 5.7 and 5.8), should we
>> just get that commit reverted instead?
>
> Why is this still broken?

Sorry, I hadn't seen this.  I'm not seeing a boot failure on 5.9-rc8 with just
CONFIG_HARDENED_USERCPOY=y in addition to defconfig (on QEMU, though I doubt
that's relevant here).  It looks like the fix is to essentially revert this,
which I'm fine with, but I'd prefer to have a failing test to make sure this
doesn't break again.

Guo: I don't see an actual patch (signed off and such) posted for this, do you
mind posting one?  Otherwise I'll take a crack at constructing the revert
myself.
