Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7416C2EFD26
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbhAIC3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbhAIC3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:29:00 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE64EC061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 18:28:19 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id d203so13707419oia.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 18:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+XgQyUnCoOiGgr+1GYfr3DJzHJ7A/npVw+YL/876VE=;
        b=H573ePv/AtnMkHsZ/24KmwfivLwt9HN3mg9yC5QfsVSoMmqUrG5/amVIQqaTb2t0CM
         FLVOJzbi35ExhVdMJzfE3JAWoT9HGQTdBFmJ+OoCW1O5uRQjJmcS7rM1O0eYfImON91r
         bhwiUD3Dhy6qX2p+YPHRdG7fk1auT8789ykXv4xoCOs/xIo8iknnaREdcia91KDx4c+r
         9t6nsPGupWmAg85kEBzqR3F0hYjAMq0hDskkJlm8gf/N+rrmQRkx4mRfmRwui7ZP8mTj
         b/yMYnSSnsrHd/SxLCwW62tTG51fe6GOHYrProzWqnR5nAE3ltC8Fh/xgob0sFqoKZ89
         PB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=b+XgQyUnCoOiGgr+1GYfr3DJzHJ7A/npVw+YL/876VE=;
        b=ByhIYsqo17oWhFN7GRRZUy9WlEkks+wL1EE/ZDlakC5SsivoXmgvm9YP0952xabr9Z
         In1YIjNyct06CxJGz2s1la/hxiOKpH0PZQtlPNEYIdv9rG4GIsMephU79bxsIJ3V1iaC
         Bl4Mlq2teosolerlxJI0QtGr2pUyPkmqAwt0rDD9v4zpwULb2PPf3KlvYLBy96QAh/WC
         +dSbulgDdya4dz8a3U5EnahXBCDXJp3BhUeO/A/kHyJukctj1dAfcgh8y1AYm/Jbx1vh
         nPYrWn4Hu4hBj46dEhFDlNScjLjFW3ZJXI8a6QvaW/b44GZHH8rozG9rWho9cXin+lKI
         aOtQ==
X-Gm-Message-State: AOAM531+Aiz28EmeI70xjNJWDDe3cqvfnaoFs7JBJc4VxCw/S/QrPDzv
        M2s9eFoqOUNan7DRdqlMa7DgbXfFmg==
X-Google-Smtp-Source: ABdhPJx0RwIuDfslO2eAucrgo1mhyrE/6nkIyMV1jjk2o+eEfGJCT0lUuoCUUCw+tNgzgBP74uV4tQ==
X-Received: by 2002:a54:4e81:: with SMTP id c1mr4003808oiy.52.1610159298968;
        Fri, 08 Jan 2021 18:28:18 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id s77sm2145277oos.27.2021.01.08.18.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 18:28:17 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e49d:8694:914c:6014])
        by serve.minyard.net (Postfix) with ESMTPSA id 9B0CA18003C;
        Sat,  9 Jan 2021 02:28:16 +0000 (UTC)
Date:   Fri, 8 Jan 2021 20:28:15 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ipmi_msghandler.c question
Message-ID: <20210109022815.GA3324@minyard.net>
Reply-To: minyard@acm.org
References: <CH2PR12MB38958D50FDBA94E2127CA993D7AE0@CH2PR12MB3895.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB38958D50FDBA94E2127CA993D7AE0@CH2PR12MB3895.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:37:04PM +0000, Asmaa Mnebhi wrote:
> Hi Corey,
> 
> I have a question for you related to the following function in ipmi_msghandler.c
> 
> static void __get_guid(struct ipmi_smi *intf)
> {
> 	int rv;
> 	struct bmc_device *bmc = intf->bmc;
> 
> 	bmc->dyn_guid_set = 2;
> 	intf->null_user_handler = guid_handler;
> 	rv = send_guid_cmd(intf, 0);
> 	if (rv)
> 		/* Send failed, no GUID available. */
> 		bmc->dyn_guid_set = 0;
> 	else
> 		wait_event(intf->waitq, bmc->dyn_guid_set != 2);
> 
> 	/* dyn_guid_set makes the guid data available. */
> 	smp_rmb();
> 
> 	intf->null_user_handler = NULL;
> }
> 
> Why is wait_event used as opposed to wait_event_timeout? In the context where the dyn_guid_set value doesn't change from 2, this would run forever. Wouldn't we want to timeout after a certain amount of time?
> 

The low-level IPMI driver is guarateed to return a response to a
message, though if something goes wrong with the BMC it can take a few
seconds to return the failure message.  So it shouldn't be an issue.

-corey

> Thanks.
> Asmaa
