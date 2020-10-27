Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E297C29A645
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394691AbgJ0ILE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:11:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32797 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393441AbgJ0ILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:11:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id l2so1203052lfk.0;
        Tue, 27 Oct 2020 01:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c4U/bePG4EkRAuU7q5fD+zQ7TcaCJxzYB3PUucsW7gA=;
        b=VtvdjqUz4jYjKsVbgEPwdhr2m294Ct33uTTTs/TMruXg3X89PXEMW2CdWV7doa7ubD
         Erahb4R3z62GIhtHOtC5f8/qWrnTstSaviHvQ/rfh19BWEGZqiDgIi4UoXO4pZVxpSYZ
         C4dumzqBGHISjXdBc/5ppOIH9cm3TI+s0S3UeNR12+KOXpUTu3AU49t6bVnYZVbHRUC1
         sBJUrGtgXtoVBijsFdHG2j9s/0hQukvfVDcGh72TYe9hsw7otn1+Nt9EtPenK2x/iud1
         6vXCHIoEAQul14zlJ1vb7SqFGlSby6QaOCTtSF7U1HfG6/0FOn3a0b50y/NoUcb9Kl4b
         LIDg==
X-Gm-Message-State: AOAM533DKyguJdyt/VMXyLrBtPeAjNlSJjUoPv5iW3r+/n1zH2lZYn4I
        n8LYPlz8gY3NuhdNr8aooaU=
X-Google-Smtp-Source: ABdhPJx+/yd7bjRy+5Wp+6VCZKqPKqTGc1rcK3Fr4HvX3t1S6NNQLIjX7Q48sgkV24ILhmh+7WKD6g==
X-Received: by 2002:a19:671c:: with SMTP id b28mr412518lfc.40.1603786261666;
        Tue, 27 Oct 2020 01:11:01 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f25sm85962ljk.57.2020.10.27.01.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 01:11:00 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kXK4K-0001G5-B5; Tue, 27 Oct 2020 09:11:00 +0100
Date:   Tue, 27 Oct 2020 09:11:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] USB: serial: keyspan_pda: fix up write
 implementation
Message-ID: <20201027081100.GB4085@localhost>
References: <20201025174600.27896-1-johan@kernel.org>
 <20201026121318.4mqwkkhahnsujngw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026121318.4mqwkkhahnsujngw@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:13:18PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-10-25 18:45:46 [+0100], Johan Hovold wrote:
> > This series fixes a number of long-standing issues with the keyspan_pda
> > driver and reworks its write implementation so that it can be used with
> > any line discipline or for a system console.
> > 
> > The last few patches cleans up the xircom device support and some style
> > issues.
> 
> Thank you Johan. This series fixes quite some issues including the
> in_interrupt() part. I added the buffer part because it hurt to see an
> allocation for one byte. There is no loss without it :)
> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sounds good. And thanks for taking a look at the series.

Johan
