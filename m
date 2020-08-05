Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A6823CC6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 18:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHEQpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgHEQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:42:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA1AC034621
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 06:04:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so13026907pgf.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FnY/wOfG17U2evXDryqB1R65hFqH8w+FrGcWYVmAVPo=;
        b=NdPdO2Qp3EtI8fJ/6wWI5wjq47zVlVrky1fF0BJcsc0oi+v+TxcjSeukF1xTd60AlU
         ze58kZphJ5ivGUQndd0DNaxqElFoFtB+aVL/m6+0lxRzFovh+IUBc5GGdqTSWj5ZD6nX
         zM9xqQxaBSj8UWPJQTuyQIS85hSGP9baInt9emfy6AsYHx+SIsVrlQ9nM/pSibHo383S
         V/bmYrQIa+r1SIz3NZJtqrka1eHUP/tlV0AdJqsO4QzQUAmpFx6p+zfFcSSrerEespBX
         IFkPVKqotTiRy1UUrS27cjNsmopQ0iK9pb+ctyPPqdW+1xivubkl9396TMFGOWR1fX4o
         UjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FnY/wOfG17U2evXDryqB1R65hFqH8w+FrGcWYVmAVPo=;
        b=Sizbz4nUNK+yW21wjeY6JF8zD0bVeYi0ydQRorph1uU27FBlG8H6wqohbdGGdQlqs/
         99KlC6RxQjPtV0jE8gkHB6oZYrBlF9imbDwRFfkGGrGCFDFGh5L59Vu5INLgrjYla6uC
         QrDC+mqro0Dcrf5N3cX+jnyGBxNoHMuqjzwKAjDgadJCr4aGio8GnukO2Bv9StJx6wFZ
         /cPLOBYdGRCbeb3XtaMu8jFHzSeplxfjps2m71MQomTCj2w//VitI+ELEHZ9zPZIFcu1
         oBgMTTJ8rfhaQNmuRFXC0b1nMnkqnrJ4tNLDbHmhJZIjSdAXPp8np9Cd3HALYqWZVweC
         9ang==
X-Gm-Message-State: AOAM533V++bAh3pvgxmUtFP6F4J8ucXfZbbdtOQomG70M211xH4SdEkG
        yaezsskciQA3as9fEjMfghVEyA==
X-Google-Smtp-Source: ABdhPJx7S819oCITEbdX1G81mfh3R1LyaJcjIYWSwKa5durMR8TWUF5eY60q1dM6Mwb+JYswZbrvaA==
X-Received: by 2002:a62:7f0e:: with SMTP id a14mr3369514pfd.320.1596632684631;
        Wed, 05 Aug 2020 06:04:44 -0700 (PDT)
Received: from localhost ([223.190.59.99])
        by smtp.gmail.com with ESMTPSA id n12sm4200840pfj.99.2020.08.05.06.04.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 06:04:43 -0700 (PDT)
Date:   Wed, 5 Aug 2020 18:34:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        cristian.marussi@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200805130436.3d2g7z2rsdoesuuk@vireshk-mac-ubuntu>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <a3354ae8-f40f-83f2-d6eb-7f588af75e97@gmail.com>
 <119ce268-18dc-7a4c-b0b2-3a66ff9ff4b0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119ce268-18dc-7a4c-b0b2-3a66ff9ff4b0@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-08-20, 12:04, Lukasz Luba wrote:
> I know that Viresh is going to develop patches and improve these
> cpufreq stats framework. Maybe he also had this 'aggregation' in mind.
> I will leave it him.

I am only going to look at cpufreq's view of stats independently from
the firmware.

-- 
viresh
