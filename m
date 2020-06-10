Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6791F556D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 15:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgFJNMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 09:12:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38762 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbgFJNMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:12:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so947258plt.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HfPSWZ3qkRuMWXYjDfciqKAxQu3R7E4m6zPaEBh66ng=;
        b=srJYFM7/LhUijxYzZG7/erVg2eGjfDP73zYY8LTxqbXRdz4Zzrk8QsxVEcMWslGL11
         XCy8IcyaX7cfuuEbmJiaH7pcHHLVBqsG7alHMPvPSw9aQuzjY182XHHTTZOyMrziOmNF
         6Bb8okJwuDjciC9IVps2Yxx38t0IBObfC4RBs6f65tF7EyeL/wj3ku7tDuuJQnCWmcvr
         +7XB92XNZ/eVovMp1meKHM9OJ4W97Aka33gGOmBwyzuNdQnKaxuMWzUE3zdSxLQpVSxa
         fjFQESRC1XYSUhT2IyGyIih311zuaVfdBQIBzpPtDtp5jaKgpPeUgQkExzGXrlO/cI8U
         eOHg==
X-Gm-Message-State: AOAM532BRGYi7irFVr6BNeueBYZzdb4LkElYLe/rqVfd8n5XArHuBTxj
        5uEPzzbDVkZUmI30hb/+qC4=
X-Google-Smtp-Source: ABdhPJxYrdDjjON737xwTPAuEWTIaxKF0cFQ+p1RXdW+rS80DQLwzvfORrrmPG1Nod4xEDfMKvx2tg==
X-Received: by 2002:a17:90a:7806:: with SMTP id w6mr2848849pjk.24.1591794731559;
        Wed, 10 Jun 2020 06:12:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s23sm5272950pju.35.2020.06.10.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 06:12:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B0096403AB; Wed, 10 Jun 2020 13:12:09 +0000 (UTC)
Date:   Wed, 10 Jun 2020 13:12:09 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86-ml <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/microcode: Do not select FW_LOADER
Message-ID: <20200610131209.GT11244@42.do-not-panic.com>
References: <20200610042911.GA20058@gondor.apana.org.au>
 <20200610081609.GA14118@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610081609.GA14118@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:16:09AM +0200, Borislav Petkov wrote:
> 
> Also, I'm working on removing that homegrown get_builtin_firmware() and
> use the one in the fw loader:
> 
> https://lkml.kernel.org/r/20200408094526.GC24663@zn.tnic

I would like to still encourage this, even with this patch in place,
as I think it makes this a proper call, and reflects better how the
firmware loader is used exactly.

FWIW, firmware loader will be changed soon to not be modular, and just
built-in or disabled.

  Luis
