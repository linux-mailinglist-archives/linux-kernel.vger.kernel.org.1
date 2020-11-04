Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B12A62DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgKDLG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:06:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35996 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDLG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:06:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id x6so22527870ljd.3;
        Wed, 04 Nov 2020 03:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46qic9gxmBR5O+V3e6aJntEIOnte/ybgRqaCaVRJqdk=;
        b=tFdpq0GSAUMh7bU1k0J5DWLEMxDpj7c/2QHTN00sU+jGQR9o7bpJcQ0CtpzLkTYSpU
         v4LiA/q9f7FGNTwbhKDe8VSL+PzVRDGRxnj9RGg9xMSFofdM3LbNyjlpLnrddbx8Mgwk
         V4YdMnyB78TB0fbX20Npgq9F86IhzWGNPgv8frlvs/vzwYjiHltdEAU0Vbm0BksgSi35
         nq6S6UDQYiqxrn3IDqtdIwj7BQAzmdxvK8yZx74g2rqxnz61QAZAWw6JeX1yUjVG/91q
         bmFlJiK+5eRaS6mnvlGVciJ/0bWEkZV25TtmEUZ6PpGeMzCmyAJyccxptBQwwz2Udd9I
         Cygw==
X-Gm-Message-State: AOAM533cMtUJGh92txymtBtYoNsA1gIabIG1AXU9KXXRnOR0XaMkVVP2
        1sa0aspf2v2L3dL0lYa6XgjbbIvDBTryiw==
X-Google-Smtp-Source: ABdhPJx2PCrcXL2ZH4ykq1nhmTJIYe+5zflLA7oGv3ob0MF6bLpyOKdJy5voeutp8h+85+VtUhGoaQ==
X-Received: by 2002:a2e:5016:: with SMTP id e22mr11245541ljb.301.1604488015291;
        Wed, 04 Nov 2020 03:06:55 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x20sm480216ljj.139.2020.11.04.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:06:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kaGcz-0003o5-Hz; Wed, 04 Nov 2020 12:06:58 +0100
Date:   Wed, 4 Nov 2020 12:06:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] usb/mos7720: process deferred urbs in a workqueue
Message-ID: <20201104110657.GW4085@localhost>
References: <20201102211450.5722-1-dave@stgolabs.net>
 <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:40:14PM -0800, Davidlohr Bueso wrote:
> On Mon, 02 Nov 2020, Bueso wrote:
> 
> >There is
> >also no need anymore for atomic allocations.
> 
> Bleh this is a brain fart - obviously not true as usb_submit_urb() is
> called under mos_parport->listlock. I'll send a v2 unless you have
> any objections.

The conversion looks good to me otherwise; it's not making this parport
mess any worse than it already is...

But please try to be a bit more stringent when updating the comments and
printk messages, for example, "runs *from* a workqueue", "schedule a
*worker*" or "queue a work item", etc.

Johan
