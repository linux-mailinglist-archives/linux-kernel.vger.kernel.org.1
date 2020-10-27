Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6343E29AB68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750526AbgJ0MEb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Oct 2020 08:04:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56996 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750510AbgJ0MEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:04:24 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kXNiA-0002wk-0J
        for linux-kernel@vger.kernel.org; Tue, 27 Oct 2020 12:04:22 +0000
Received: by mail-pg1-f197.google.com with SMTP id t1so615536pgo.23
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g5lMmHon4rLqdhfDcuQVTLa+kEfIqO1qNhvdTbwo9VE=;
        b=mXWH80sPFzIxVIqq1Sa2ZHzDUcsA5sgGtsalb61gAl3+CxdEP6JVlRx9TY1kH0HNaq
         FSXWMQG0Z8DQSRleGl1P18A7HEQRsKKyBj2d1xziIL2nN27hI4Co6BzOz4eqkoUf7hSt
         ImSD8u2m7ylNbVSknuepIfnzttV0UlKGssJ+h3jypGzpb7MSj1TJyCR/e/+CP8PIV1X9
         d7XD5H1P9AUDqmYFs29PbymCntSA76rW2FNnrVwbpEtBOchRh44oQGowavzdiNMELJST
         cMRGN2296zNOK3cCZdrzmD4XsE6p5x17V1Zo3Q3mHDgWtC6FaNrmqNXF0AVlicItyKA6
         G25Q==
X-Gm-Message-State: AOAM5301eqlfw5TesO3NALUOZZylpQIUu440MV0y/w46RIDYT1goPPdi
        ENuZHKKx70QShEY0vII5XjWgHBwdNR7uTzChENR+QqbRZpwS1W9QMx8zaOpfbVwOFVFiNrQcPy6
        tNcWtcOkxIOAAaB+TnIDBaoBT0HrGoi4spaQVOkhHGw==
X-Received: by 2002:a62:e811:0:b029:164:4551:926c with SMTP id c17-20020a62e8110000b02901644551926cmr771308pfi.27.1603800260327;
        Tue, 27 Oct 2020 05:04:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkwkAm24quZb/7ZS367uG9huFpMxKFdCxU2Jbv7cnHasxj90Xl93+QTMO+B+KuQgU2yXpsFw==
X-Received: by 2002:a62:e811:0:b029:164:4551:926c with SMTP id c17-20020a62e8110000b02901644551926cmr771279pfi.27.1603800259984;
        Tue, 27 Oct 2020 05:04:19 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id e23sm2099586pfi.191.2020.10.27.05.04.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 05:04:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 3/4] ALSA: hda: Separate runtime and system suspend
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <alpine.DEB.2.22.394.2010271317430.864696@eliteleevi.tm.intel.com>
Date:   Tue, 27 Oct 2020 20:04:16 +0800
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com
Content-Transfer-Encoding: 8BIT
Message-Id: <468FD7B1-A6A6-4D0B-B27B-B66696424A48@canonical.com>
References: <20201027054001.1800-1-kai.heng.feng@canonical.com>
 <20201027054001.1800-4-kai.heng.feng@canonical.com>
 <alpine.DEB.2.22.394.2010271317430.864696@eliteleevi.tm.intel.com>
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

> On Oct 27, 2020, at 19:38, Kai Vehmanen <kai.vehmanen@linux.intel.com> wrote:
> 
> Hi,
> 
> thanks, this looks like a good improvement! Some minor notes:
> 
> On Tue, 27 Oct 2020, Kai-Heng Feng wrote:
> 
>> Both pm_runtime_force_suspend() and pm_runtime_force_resume() have
>> some implicit checks, so it can make code flow more straightfoward if we
>> separate runtime and systemd suspend callbacks.
> 
> straightforward -> straightforward
> 
> and systemd? Maybe just "system suspend"? :)

Typos :)
Will update them in v3.

> 
>> While at it, also remove AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP, as the
>> original bug commit a6630529aecb ("ALSA: hda: Workaround for spurious
>> wakeups on some Intel platforms") solves doesn't happen with this
>> patch.
> 
> Hmm, so this was gone already with the v1 version (so not related to 
> programming the WAKEEN when going to system suspend)?

Yes, I was worried that this cleanup may regress the user again.

> 
>> @@ -143,6 +143,7 @@ struct azx {
>> 	unsigned int align_buffer_size:1;
>> 	unsigned int region_requested:1;
>> 	unsigned int disabled:1; /* disabled by vga_switcheroo */
>> +	unsigned int prepared:1;
> 
> I wonder if "pm_prepared" would be better as ALSA API has a prepare method 
> as well and this is not related. OTOH, if ok to Takashi, ok for me as 
> well. 

Sure, I think we should use different terms.

> 
>> +	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
>> +		   ~STATESTS_INT_MASK);
> 
> This would fit to one line now. 

Ok, will concat the lines.

Kai-Heng

> 
> Br, Kai

