Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B2420261F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgFTTOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 15:14:52 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52669 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgFTTOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 15:14:51 -0400
Received: by mail-pj1-f65.google.com with SMTP id u14so528891pjj.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+UJaQYOsGkaPPFrhfc+qFPV1DgBwFfHxm19AGN28PeQ=;
        b=H9d7Os4DB4BeQHYJ9Dw/XvCCqgmyNwwZwBUuV4UR7jhz2B9xHpH8TVRc9kKJGlE5QP
         IyagLvJ99q6ofc3/5sOiKzWF80y4wj281myPXgE3MuK6WxdULd8URxVCsJ/jQZhVbwga
         6b3OWTeZeq7++oTTubPTgZj/J6LMI0K4lyd7GPomiiXNUBS0QUGBRAOA28itZVCNFLGk
         tHra702nfHU4ROiFdaYzjBeeyGumwxTmM5Kokl6JpAj18sedMDDLg2HTNQ4Pkto73kSD
         uLhyZuWIsounDGPaGrVSO1iQh2lmAwTU5EzGzPVxKk9eCXOlQdDi1XPl1LRLtl+s6M6T
         5Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UJaQYOsGkaPPFrhfc+qFPV1DgBwFfHxm19AGN28PeQ=;
        b=CkfA3ex1YUrTeC9bkBpfAYTPkVo3u7uP72q+A0yU9C3b8ja0mp2XCZqhxT6Qgir/77
         B0/xm5Mo+oa2Ac2Df416dOC9Fgor9a6NcpVNFVrosPFxvLMjsyaAdSrpazfbiUH8qu39
         Z0qITNnS7+X0axillDvHK91G/LqFCRdwfajOhH9hQa0WKrqYB295vqgMFUaVhqPXQ2r2
         DzMwLvQj++N4hINLcrNJdNEUZV1owRop00tFV3RAMQJIH80lzt8TV67Sn37bGHDpECkn
         SJhyPyLYCLI+X5giK4+GNP3e4u2DrgUz3XaPEyMCqUKoccyEkTsxdgyErSNbTxBabqU2
         dUYQ==
X-Gm-Message-State: AOAM533j6cII1izWMjT3ocApcH+uI2haABxTVRCw39RuW39ZEuCero5H
        c7VpNBrT9sp8Inr/mf9WNChxNfVy
X-Google-Smtp-Source: ABdhPJyHyLSky9JnX4C3m+p62NIYPC7Ias1fmeJ+rLDBUyrYzc9fvj2jbTyJFqbLwGdFHx0CFPdxSQ==
X-Received: by 2002:a17:90a:950c:: with SMTP id t12mr10189498pjo.173.1592680429854;
        Sat, 20 Jun 2020 12:13:49 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id t9sm8310768pjs.16.2020.06.20.12.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 12:13:49 -0700 (PDT)
Subject: Re: Banana Pi-R1 - kernel 5.6.0 and later broken - b43 DSA
To:     Gerhard Wiesinger <lists@wiesinger.com>,
        arm@lists.fedoraproject.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, filbar@centrum.cz
References: <912a58ac-6f81-ba22-c79e-f2bf902dae2e@wiesinger.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <12ed4a27-7773-98c4-c8ba-f9b0d53a5b5f@gmail.com>
Date:   Sat, 20 Jun 2020 12:13:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <912a58ac-6f81-ba22-c79e-f2bf902dae2e@wiesinger.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/20/2020 10:39 AM, Gerhard Wiesinger wrote:
> Hello,
> 
> I'm having troubles with the Banana Pi-R1 router with newer kernels. No
> config changes, config works well since a lot of lernel updates ...
> Banana Pi-R1 is configured via systemd-networkd and uses the DSA
> (Distributed Switch Architecture) with b53 switch. No visible difference
> in interfaces, vlan config, bridge config, etc. Looks like actual
> configuration in the switch in the hardware is broken.

Can you share your network configuration again with me?

> 
> # OK: Last good known version (booting that version is also ok)
> Linux bpi 5.5.18-200.fc31.armv7hl #1 SMP Fri Apr 17 17:25:00 UTC 2020
> armv7l armv7l armv7l GNU/Linux

OK, I suspect what has changed is this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fab459e69abfd04a66d76423d18ba853fced4ab

which, if I remember your configuration correctly means that you now
have proper DSA interfaces and so all of the wan, lan1-lan4 interfaces
can now run a proper networking stack unlike before where you had to do
this via the DSA master network device (eth0). This also means that you
should run your DHCP server/client on the bridge master network device now.

> 
> # NOK: no network
> Linux bpi 5.6.8-200.fc31.armv7hl #1 SMP Wed Apr 29 19:05:06 UTC 2020
> armv7l armv7l armv7l GNU/Linux
> 
> # NOK: no network
> Linux bpi 5.6.0-300.fc32.armv7hl #1 SMP Mon Mar 30 16:37:50 UTC 2020
> armv7l armv7l armv7l GNU/Linux
> 
> # NOK: no network
> Linux bpi 5.6.19-200.fc31.armv7hl #1 SMP Wed Jun 17 17:10:22 UTC 2020
> armv7l armv7l armv7l GNU/Linux
> 
> # NOK: no network
> Linux bpi 5.7.4-200.fc32.armv7hl #1 SMP Fri Jun 19 00:52:22 UTC 2020
> armv7l armv7l armv7l GNU/Linux
> 
> 
> Saw that there were a lot of changes in the near past in the b53 driver:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/dsa/b53?h=v5.8-rc1+
> 
> 
> 
> Any ideas?
> 
> Thnx.
> 
> Ciao,
> Gerhard
> 

-- 
Florian
