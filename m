Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC948228464
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgGUQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 12:00:30 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52664 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGUQA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:00:29 -0400
Received: by mail-wm1-f44.google.com with SMTP id q15so3351135wmj.2;
        Tue, 21 Jul 2020 09:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kj4rsz080Snn4B9MG3ZbTEom1EbAEYgUHjT0erERj2Q=;
        b=MsoC2nrwA9QFN2TrodngwqSSW83ssVxsL8z4dTOdESvejPa6Ulro/x0ajMDeryahrQ
         gzZlUF53fkx4LGyXYyxmX9fLoV2jA4iyVZva5/b0ZeSSWImYImwAPU5v/FgwNCFYBHwZ
         qjxuEkWvyez+mCrhW3412vMF28PV9cLPtXsQNmOjN+kcjKrjZ1dlCbDHWWwM4Ru10rYI
         uB1Pjyt9aRNtTZCIxJ02QVQi140T0M6vnHT/8Yw4py41AhHUipL/W4efCSPVeZQ6DY6u
         DNln2uPv43FCfeWJgBGBM2tDY4stueEJOl8Y3sebVNHDhsSnoIhzLT+UPBOcQF31wwie
         CNXg==
X-Gm-Message-State: AOAM533mNzEoTeGbQsTu+hJmb+dfDxf52ai7n2xaMMKywptbnYnemMNN
        1A/GAtmzgB0zy1V6EkTOAK4=
X-Google-Smtp-Source: ABdhPJziu+Xxu9YdgzKr7PT4T+W9SMer6L/whdz53Wdb7MYjUO3T40Yx4hEbcMOQz3ZpfMz9J0OH2A==
X-Received: by 2002:a1c:65d5:: with SMTP id z204mr4602923wmb.15.1595347227554;
        Tue, 21 Jul 2020 09:00:27 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id s15sm4234729wmj.41.2020.07.21.09.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:00:26 -0700 (PDT)
Date:   Tue, 21 Jul 2020 18:00:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200721160025.GP4061@dhcp22.suse.cz>
References: <20200720143213.GJ4074@dhcp22.suse.cz>
 <20200720151255.GE1228057@rowland.harvard.edu>
 <20200720163355.GA4061@dhcp22.suse.cz>
 <20200720173807.GJ1228057@rowland.harvard.edu>
 <20200720174530.GB4061@dhcp22.suse.cz>
 <20200720174812.GK1228057@rowland.harvard.edu>
 <20200720181605.GC4061@dhcp22.suse.cz>
 <20200720200243.GA1244989@rowland.harvard.edu>
 <20200721055917.GD4061@dhcp22.suse.cz>
 <20200721143325.GB1272082@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721143325.GB1272082@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-07-20 10:33:25, Alan Stern wrote:
[...]

Thanks a lot for your analysis. The laptop is slowly dying so this can
be related.

> So yes, this looks like a hardware design error.  Turning off 
> autosuspend by writing to the sysfs power/control file is probably the 
> best way to handle the problem.

I can use that workaround. But it seems that this also prevents me from
suspending the maching into RAM with
PM: Some devices failed to suspend, or early wake event detected

:/

If there is any workaround for that then I would be really happy but
considering the overal state of the machine I suspect this is not the
case.

Thanks again for your great help!
-- 
Michal Hocko
SUSE Labs
