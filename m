Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A7529DCA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbgJ2Abf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:31:35 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:42803 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgJ2Abb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:31:31 -0400
Received: by mail-ej1-f68.google.com with SMTP id h24so1437335ejg.9;
        Wed, 28 Oct 2020 17:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1VntsxMvFKCK5dpd6VOSgTOJZZaGGEWGvB0qlBcjNQ=;
        b=Y+Uj6qoc11NgFkRWLMmpqp0lK91j3O2ISqNwbOcaGpxNHGZA7vqKlklMqNCvkOXf+p
         8dYBqQNxrRRjv+gQM0VgfIiw0In5816mRrmxYuQ7brTptv6aY9s2UoEvZCmRUVQWRqdf
         10+Ja2oMYEEuJLhwTgiVk/KswtSjvkLa8pbh0b3OVK9ag/XKNaO/VxsWesTEsBu+ssKd
         DMuo1Ur59R8P9NI6Os2HnSNaAm0x03VLUZzzFJ5aALtej9cYJBkLNe3NrIruEOXeTQYg
         F5/i9H/4fWJg17FLOQJYfbdqNEjTMhDoP8iCvoKoTuDM4X+QREU61NBnMA4LPgMSTt3o
         WyDw==
X-Gm-Message-State: AOAM530tLqR5eVYBLGvI+zZXSCE9al8dkAbx3t5oS6jOnKjyyJrH3Lfa
        i9EaJfMsyABwmenlGLhNLUfOlM/0FMdq0w==
X-Google-Smtp-Source: ABdhPJyL/s7ktV13SffOusuums32sHtM5AYxTnP9mrEentbnJELIcW8X4V5ccKGskS5qd10S5eh8Rg==
X-Received: by 2002:a2e:4541:: with SMTP id s62mr88384lja.128.1603869281068;
        Wed, 28 Oct 2020 00:14:41 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id l8sm408309lfc.50.2020.10.28.00.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 00:14:40 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kXffL-0005lK-8s; Wed, 28 Oct 2020 08:14:40 +0100
Date:   Wed, 28 Oct 2020 08:14:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ziyi Cao <kernel@septs.pw>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: serial: option: add Quectel EC200T module
 support
Message-ID: <20201028071439.GH4085@localhost>
References: <17f8a2a3-ce0f-4be7-8544-8fdf286907d0@www.fastmail.com>
 <20201027084317.GF4085@localhost>
 <06d58779-da02-4588-8871-0d05e794429f@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d58779-da02-4588-8871-0d05e794429f@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 08:34:09AM +0800, Ziyi Cao wrote:
> Hi Johan:
> 
> `lsusb -d 2c7c:6026 -v` dump, in attachment file.

Thank you, I've applied the patch now.

Johan
