Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36B12DE939
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgLRSsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgLRSsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:48:00 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C0C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:47:19 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id w3so2798435otp.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cQPQUUF+WXO+MF+lPzw5b97hlqDrH2P1Y51xQJCAlLY=;
        b=Xln4aDqFfyJFBLceqLjyPAmb997alpa+GBCFESPwE/D6u1BMIWHTdZF5hxdvwAFAwc
         6iJEkv6BenQpPIXTIkswngbEGGZEChaZwRrPxt4fYj2785pOHwK78cLGZBuO2hRjws+i
         HRNHNCShitTUflRAN7dWfdb++4f/cM37tA99RTkn23SGdXRLsprQRZr/e0dNF5ldmL4C
         IBb3JaeYzNjcA+bJpkwUyWSOB/U1DVxi/iCdTYS8bN7heyI0rRTtNuyazxzuE+WZTPX2
         Oc9YpVZGUxaOKzVUhywunNeK33QEBVUkVBPwH0Fv2L3vcPAn1Xb3XE6hHA/AkvTXS+vl
         PEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cQPQUUF+WXO+MF+lPzw5b97hlqDrH2P1Y51xQJCAlLY=;
        b=qhIGALA/o2MiTn0thfH3dpMimbc43CiRh8geVlt7ktD662C6OoTycyG5UpgpGpUPA3
         us5yzAed5yJGtV2IpO1G7ENpTT9bCAxF7XQjiZIKC9kPxfnHrcdJD2euENFPiHvpN5gH
         hBbjv991NiIDFEmQLaUmI9dZhdWOkDIEo9v154P6yDVOvOglBCeRX9+D3HXrIbX/jajT
         CpKbe8hCnfK82gjszScN3aQgxAIlwmTNMZME5RNt6x/bHqO0ngdz160MfZdDtf9S/nYS
         YrDszkleJCr6vVsjK3IGPo/C/ase8roFD+0yvatuga8qsejAs/rbTW6KxW/TYmeJrpab
         M8fA==
X-Gm-Message-State: AOAM530Gup5SRCkrRvKBAeAyz8Ed+47e+NSiDMBrUCQBp08K5MxJkpNb
        G/O/GDJPcZH8dF+eDxDBY2caIWjsAkQ=
X-Google-Smtp-Source: ABdhPJyA0rK6bjATltpQM6PYwoS/b+o5kWf1b3cmeGTZCYqPmfQeJeoRDxHs0F6DBimE6fmVIB/8vw==
X-Received: by 2002:a9d:38e:: with SMTP id f14mr3875027otf.201.1608317239255;
        Fri, 18 Dec 2020 10:47:19 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1sm2029961oij.9.2020.12.18.10.47.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Dec 2020 10:47:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 18 Dec 2020 10:47:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Scott Branden <sbranden@broadcom.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 3/5] irqchip/bcm2836: Make IPIs use
 handle_percpu_devid_irq()
Message-ID: <20201218184716.GA10928@roeck-us.net>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
 <20201109094121.29975-4-valentin.schneider@arm.com>
 <20201215002134.GA182208@roeck-us.net>
 <38f8fbe9ceb7a0adb47e62d62260b297@kernel.org>
 <1795afb5-a4fd-3a90-99c4-71373476ad65@roeck-us.net>
 <9007dd8a0d5334141d083b14121ba11c@kernel.org>
 <c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net>
 <dff83a32c64bad6e3880dba8804cea6c@kernel.org>
 <0334f005-1c62-cad0-37e0-3b1eb3ee4082@roeck-us.net>
 <87tusjq7nq.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tusjq7nq.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 06:40:57PM +0000, Marc Zyngier wrote:
> On Fri, 18 Dec 2020 05:18:31 +0000,
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Any news on this? I now see the problem in mainline.
> 
> I have just queued the fix:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-next&id=d7f39c40ebb6986e7371510d1c20a4efee4a7f0d
> 
> Thanks for you help in reproducing this.

Thanks a lot for the fix!

Guenter
