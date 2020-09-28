Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCAD27B1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1Qbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgI1Qbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:31:53 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3710C061755;
        Mon, 28 Sep 2020 09:31:52 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 60so1531235otw.3;
        Mon, 28 Sep 2020 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IRAWYiQ1GCGSlHPkfgGvGRuzfd4N+24+EgOwtiWIZpU=;
        b=FeajeMxJNB5HezesR0mun6c7dtWpk0jW0Bb1qxHWOKJFMlY8ALExYd5LOLvvJunSJ7
         gKt7UGzLTgxK53RnAXFxSfeDAnZrjDbD87W1bi8XQWeklFa9+gN7VGvIO/yEsZVeE7Yj
         +6pEJSstIuTQWTnfN0wwQ4Yc4Qlnc9muoGdAraonMPFZATcOyFZfgiZJNjTqCRg9PT3j
         1a1JpQaeT6hBUyAShg5+OdR+nFQLlcPniOaJQFOAe2LBIMs6Is08UhRaR85bS+rhezCB
         mtkePpls/OGOBGTiwmb/WSF6GLS3FMqOs3TUGfr8r4rSlMFPlzpN9HEQ9YVLNm2sCokS
         v9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IRAWYiQ1GCGSlHPkfgGvGRuzfd4N+24+EgOwtiWIZpU=;
        b=P4+ngH7MpJ9CwTOq+S9xVwyiTYxlUZXciSERqcTPbWzigwUbnFeTDFdAmjzSsOCLw1
         b0xwAqe4P0qcacOov1cFrqzHGsOyP429HywRmFTDx6ZSb1ITyqDyqFD1U2fJWWY2/gu2
         peZk96FhIRXDLEHk/v8SnTkpFY5dfa9HP1qW15NoTfstXmpCN6zmAWNzNRxiXzL6I+re
         DPG3GoA+ZaU/2FX+hDw1/HfxxBEd19R433NgUwi7vfzsjKEDB+oufs8dJTMslonsBRWQ
         lie1CYIDO2h5whRQ3kFKF6cF2gBwp3bkuMqsOy0B9JwGs9HKHxayW9eEtyasf0xNczXI
         lKBQ==
X-Gm-Message-State: AOAM5338eJvTyhu/O8MqhoIkuxrc+X4eGoYuMjNB2LTJ9QiNIsJBCUjW
        MXg6CKQv8FDlJo9+fSLyI7+KXPt0ERE=
X-Google-Smtp-Source: ABdhPJxtr2reINcBsglzoojRaT8uk9usE2tJNLR7gztdd3GBFvm6xgcAtqhuDp9H/5DFYuRFxVb3NQ==
X-Received: by 2002:a9d:5183:: with SMTP id y3mr1535373otg.285.1601310711824;
        Mon, 28 Sep 2020 09:31:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 36sm330426otb.30.2020.09.28.09.31.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Sep 2020 09:31:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Sep 2020 09:31:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Bedel, Alban" <alban.bedel@aerq.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] hwmon: (lm75) Add regulator support
Message-ID: <20200928163150.GD106276@roeck-us.net>
References: <20200917101819.32045-1-alban.bedel@aerq.com>
 <20200917101819.32045-4-alban.bedel@aerq.com>
 <7986c014-b826-bad1-f19c-cdda31d20804@roeck-us.net>
 <d3c7959cd1e775ae4680a446328f271e7d6c42c6.camel@aerq.com>
 <20200928162948.GC106276@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928162948.GC106276@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 09:29:49AM -0700, Guenter Roeck wrote:
> > 
> > This is handled in lm75_remove() where I added the regulator_disable()
> > call.
> 
> lm75_remove() won't be called if the probe function fails.
> 
Sorry, I am confused; please ignore this noise.

Guenter
