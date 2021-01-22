Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E3D2FFAD4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 04:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbhAVDFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 22:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbhAVDFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:05:49 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 19:05:09 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q131so2765294pfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 19:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7WAx2nccWmzEdsODAWKhq/59U7lfHX2jsurB6+JMLsw=;
        b=D6djuXzODIlL7l5Rrgide9Ftif7VFzrKoRyAkzxylF8qkbQWhYBF6pANY2SZOcUitL
         qvBAEjIE8z6kQP5cVCJvAMB7UQfHCniyMVBkHcLppClQfILYBaiHpIqh8rLNsNSj0ohJ
         5Fdmdwhi7fR+/PonEa+4n4GqSxp0q9v2y8UDnxAwqLBnf0XQgYl129yfQ0yj4l8N7ANG
         1G/gTF7WluXTDMXvLUAwEP3soUfq9I9l5+YrylLk4xnsMnpz/sZy4w5VRAT6qyFbpDec
         Y9Z17Il7/gcIHMJfidXus7T6RCsWd7I6S6Tl/3+j5Fd/hFbD/hVuTmiCvHSdrjrE2LiL
         okKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7WAx2nccWmzEdsODAWKhq/59U7lfHX2jsurB6+JMLsw=;
        b=hjIlMepgDk/eB1j53qlYm3MLU2KfFVgub5uue6xclqrxGdXTvnR3BXGv/ZRQ3gG2BH
         hdcLBEStXVJ2hegXcLKOKNPk/cx4xpP9E1weEP3eWkeEbIGbbKr0vQfj+jWIytOWjQj1
         GV2GX/mD6v/d8uqrmVD/nEWHmDyjPaCQwILQR8SpeECMKp8jjBfni8Tftcw4yRXrO5qv
         gAQu28TVI+Moqixjsz/UFNzTrM3s9UgIofrgE4vT6ek82mneMPPj0Xah+JW0WASSRDIw
         nc/iHWe8Foe1nC2Uatp+i+L4Wa/tuXkQL1yBHIL5Wmq48/QnREvIq5zPx93PLsy27ArQ
         89Cw==
X-Gm-Message-State: AOAM5325oE2GyMeE9qpm5aPgHl6nRw8V1cFBOwVkoktHrAO8zk5vAo1B
        AODpzivi9ZkSrteOO02bVuD3Gw==
X-Google-Smtp-Source: ABdhPJwwP0WTirpf9k2orr9Eqi50BNfMsvjG7eZ/T9iQVn6XD12lzQGiFhDD3TDkLDrpO6grCa1rMw==
X-Received: by 2002:a62:ee0c:0:b029:1a8:db14:927e with SMTP id e12-20020a62ee0c0000b02901a8db14927emr2642645pfi.14.1611284709245;
        Thu, 21 Jan 2021 19:05:09 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id c17sm6433075pfi.88.2021.01.21.19.05.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 19:05:08 -0800 (PST)
Date:   Fri, 22 Jan 2021 08:35:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] opp: Prepare for ->set_opp() helper to work without
 regulators
Message-ID: <20210122030506.zhfkk4angmp2a4hk@vireshk-i7>
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <d60bc79ed2ac3fd2f2911449ba994b4d55bd1bfd.1611228541.git.viresh.kumar@linaro.org>
 <58d15e20-8688-99be-b107-4350ff81e90a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58d15e20-8688-99be-b107-4350ff81e90a@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-21, 00:02, Dmitry Osipenko wrote:
> 21.01.2021 14:30, Viresh Kumar пишет:
> > @@ -1952,9 +1930,16 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
> >  	for (i = opp_table->regulator_count - 1; i >= 0; i--)
> >  		regulator_put(opp_table->regulators[i]);
> >  
> > -	_free_set_opp_data(opp_table);
> > +	mutex_lock(&opp_table->lock);
> > +	if (opp_table->set_opp_data) {
> > +		opp_table->set_opp_data->old_opp.supplies = NULL;
> > +		opp_table->set_opp_data->new_opp.supplies = NULL;
> > +	}
> > +	mutex_unlock(&opp_table->lock);
> >  
> > +	kfree(opp_table->sod_supplies);
> >  	kfree(opp_table->regulators);
> > +	opp_table->sod_supplies = NULL;
> >  	opp_table->regulators = NULL;
> >  	opp_table->regulator_count = -1;
> 
> The sod_supplies should be unset under the lock.

Fixed, thanks.

-- 
viresh
