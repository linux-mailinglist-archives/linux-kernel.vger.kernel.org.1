Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D536B219245
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 23:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGHVRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 17:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 17:17:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85554C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 14:17:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k6so157349wrn.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmh8/RZ9FlfhrnUIbBHKcqtVDALQdutc7vrYQZeOGpI=;
        b=S3CdvDvpIiy2Pp5pD5ugp+eY7BV95vF07iKy/NkenpK4Fji3hbc5/m+3Aekfch/pjL
         mlqHoZ6vFkGQja7ioxfY1cBkVEoU5Lud/WZZxm1LT/gd/3RKxFoLZcDEUmZcULH/CWGX
         WwxP33DTWFEOpfZX+AA2PenH7ALCaeAirDbCHZSUvcBKHxkswgXt5yT9WWnsQxp7V8Tq
         qvqJ+azLrxX3gnD/W1a390EljKYdkxYed3Q1OVEzZ3Tdvvxkmkma1vRR1LJ+PKdSOnke
         ZCWwMAHDoOfgjTZv2Zn+mIDprdFmDWEG5nZdq5eCOkGYMnpS/TcnNhO47nPHXukF7jYP
         +LUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmh8/RZ9FlfhrnUIbBHKcqtVDALQdutc7vrYQZeOGpI=;
        b=JcOAjL2+BLujtf/YUDqBQIRGh5LFLGyneW2uIn9xW8zDuYsXjhAdtfDpwdkw7Vh95r
         c9gzrJSMSn+d9SETWWQQ08V9mhD8G1E+jX8NaQif1Rvocv8edTqi9z2Ju768JOWoeSUX
         qnwRzosSGEWht8FwyVuujaKi/Y7mzBL32IJjTMcWEc1ikYzs8w5Tn4pQf9PQqCTh9SFq
         EivmlJ0ySiZ4YkF7iV2jClkGRNeJ8bpCQuJPFaIUKDexw4LLsdxSLvyJNzdp4s7GnFhj
         975HqIHRSMAtzbSL3o2DP+/EqLifd27kZoFHVb1mtVF7npFjKQku0vm07stdZXNco2jV
         oL2A==
X-Gm-Message-State: AOAM531UJLhN1bC76TpMYyNFyXVbREbkrwgILkHt9CRQWsLrHR277Cva
        04lX7qX89lcgKjAv69HLWHB320VDk/FSq3a2VOcLmA==
X-Google-Smtp-Source: ABdhPJxkxRn409bD0sa+HsvRlC1tt7ZwsjjkVb0gLAFt52l51BMuSvIpuJeEcUScB3038AM8xNgBqUmYAI6oL6QKoOU=
X-Received: by 2002:adf:f707:: with SMTP id r7mr59177353wrp.70.1594243055813;
 Wed, 08 Jul 2020 14:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200708192804.911958542@linutronix.de>
In-Reply-To: <20200708192804.911958542@linutronix.de>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 8 Jul 2020 14:17:25 -0700
Message-ID: <CALCETrUXrX-Hu=NvL3b3koWg71Gv0wAAhG+mpa+iAasQg40j2w@mail.gmail.com>
Subject: Re: [patch 0/3] x86/entry: A couple of small fixes
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 12:29 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>  - Syzbot reported a missing local_irq_disable() in exc_alignment_check()
>  - A missing noinstr annotation
>  - Make a function static which is not longer used from ASM code
>

All are:

Acked-by: Andy Lutomirski <luto@kernel.org>

-Andy

> Thanks,
>
>         tglx
>


-- 
Andy Lutomirski
AMA Capital Management, LLC
