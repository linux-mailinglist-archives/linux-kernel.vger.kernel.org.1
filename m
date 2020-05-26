Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171671D0C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 11:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbgEMJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 05:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgEMJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:41:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897ABC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:41:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so12806260wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NJBGaruknTCLtKKJk9/NPgVcIhnHRN5HOgLiTidMfps=;
        b=nbtBTs6Xx54r3xi5mFEcv4se2zQfkJy0cQh1tbJCIw8IoMzRCEr0oal1hCN8wgjJwG
         XJfDbD6yCAuuqlDeI7Ry1xErq+ap5T/xl3ude7Kf8KxrPAOkKt0I7tT+gue0xmLf03UW
         T7e5+LBwZVFtpdt1QkXQGwAyCQ8X7HkI6BligttJ82dncMKxLO6r9/fNTKcYJySDfwIR
         cRgHstp7X6H5NMznogdlwx1FUvoY9Ns4+KsmIXMTxizqrvkKIOMTkvUTVZDFaCJS2IkP
         yWiL85KWNcfvxM1s/c5bZSWwd3Y9ECI1Dc8APHKOiNg4ZliFiPwgPuftVHjIxUzlFmWi
         npSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJBGaruknTCLtKKJk9/NPgVcIhnHRN5HOgLiTidMfps=;
        b=nNAYOHJjsuv/9tZMD2GPqnj47F3haauRN3dkHpJZmMMvLdDAK36sjPz/CCGhHXW3NH
         t95Q52lWXIxEnqped7OoUTygRR1qGP4UqM9QRwuWq4VYCpPWNZGGuWRWlPOdL8ivrvsl
         FQP1YneYqhXJVOvLQ4wS+x5lHQEc2CQikkFyh4BnZe3ChwAmg9xOoXVIQdN6g7DqOcM+
         hua5rW+Ke5gIrvGd3MSBUZAxOay1atOUvR2R0ePMkJmLtCdsl69IP8QMx8NGR132hEXU
         JgFZfzFJen3HEA/uznu4FXiuWwhDdSj5NctU1znwpOqTy1/E52piPf4mYtsCJt/Ai1PC
         MfMQ==
X-Gm-Message-State: AOAM530qQQEDWc2gy8xVedKvq+ykUI9YXhmkyaNVDPNJq1SS2Q/jwve/
        8zJiwFXxrsCvhUqV+VTKogCbhw==
X-Google-Smtp-Source: ABdhPJxIzSvxktEk0dfkDZAgXrtWIO1vC88KrHWFh9dWQyFJ4zAsOGcxznMe+hx/MAUnWP+KEEw9nQ==
X-Received: by 2002:a1c:6245:: with SMTP id w66mr7104946wmb.33.1589362881903;
        Wed, 13 May 2020 02:41:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id x24sm28184249wrd.51.2020.05.13.02.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 02:41:20 -0700 (PDT)
Date:   Wed, 13 May 2020 10:41:17 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200513094117.GB225140@google.com>
References: <20200511090049.GA229633@google.com>
 <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com>
 <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com>
 <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
 <20200512151120.GB101124@google.com>
 <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
 <20200512162630.GC101124@google.com>
 <CAJZ5v0ges4=e2HkHpVk4E1yF1VsBm9H5noqMz-MxX9DK_kt6Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ges4=e2HkHpVk4E1yF1VsBm9H5noqMz-MxX9DK_kt6Xg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tuesday 12 May 2020 at 19:30:52 (+0200), Rafael J. Wysocki wrote:
> I don't see any technical reason for making schedutil modular in the
> context of GKI other than to make the GKI image smaller, but I don't
> expect that to be significant enough.

The fact that we can make the image smaller, and we give vendors one
less reason to not-want GKI _is_ desirable IMO.

  $ size vmlinux.*
     text	   data	    bss	    dec	    hex	filename
  19225963	9601976	 491084	29319023	1bf5f6f	vmlinux.after
  19230599	9603236	 491084	29324919	1bf7677	vmlinux.before

^ that's with the series applied. 'before' means sugov is =y, and
'after' is sugov =m. So modularizing saves just over 4K on text, and a
bit of data too. Is it significant? Maybe not. But it's quite likely
that those who don't use schedutil will find any unnecessary byte to be
one too many.

I just checked the size of modules in the default arm64 defconfig, and
the median is ~4K of text. The average is a little bigger, but mostly
because of a small number of really large modules (nouveau being the
prime the example). So all in all, the sugov module is not particularly
small by comparison with other things that have been modularized. A lot
of small things can lead to significant savings at the end.

Thanks,
Quentin
