Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24282AB789
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgKILwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKILwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:52:11 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44056C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:52:11 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id s9so8180508ljo.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gb555tBVeDZ1152wJBFs/zqQc+I15TdKsfg5+AjAFMY=;
        b=VheQ6P+eFa43DzlthNUnMdFi3GfOfXKp3Gk0+ex0JvkJMOlv8YVeNPK6MhHY3U9TKc
         ehqpu7eVB8sYuUuPj2VhAi3/lGh3eM4Yiw8VmO9jrfljaLl0lTKmoSzXX/HkW8+xWuTo
         TJmr1Hm32xUoChiFhiPBpReNTzpl3hY8BQr3eDRw9mLMlJ5oaLRS3PQzKeTM+30FhbkM
         N6rR0MHpObqwxrn1yTGh+rnc1qwtXvqIoE0VtREkQxD9za0F26/0sdfXcBSlEwbv8qO9
         2S1EsdAHJHIbCGblmxivG7jeyfd1hoi9CilzOQiVaPBZeVTBp6qZF2DCv7JPplceUq8J
         84zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gb555tBVeDZ1152wJBFs/zqQc+I15TdKsfg5+AjAFMY=;
        b=NAiUDpzKldt+yY8g+TS6JhsBpG8Anw1tc+E3z7RPYQq+AGj0/o6D21u5gvZRCaGQkW
         Ixztk5O0bFvwlSo+mJFIcg1Xy1bdQX5ZkhL4HBnsUMQ5Omk6feSRW/Sbmnfll4cIz04s
         tjvZ0oS2VIL9NiPxmVh0PC/WVERA/560JnqS9iE8d25a1pE9piIKUo2uiwYk9zrsDJLu
         FVbCR8h6/BMmBuGayz7JkRdLuneu7b9yiOn9esVXrMgIcvYMpbFXz9RTR3GHqVCmfVBL
         5fTSvGFHrVcbJ0/ydbK3+MBCZyFjaIeMVPiKv0giM9cwVTWIafTfejAKURXK6gaYue84
         u64A==
X-Gm-Message-State: AOAM530EP1Vu+0W8aqnswLh9+odZNq2Yv98JLI2oYfUwcEp1L0KNiXoR
        zgIgXpCRxG/2W6C7hOEUCxH9gtL3HPRuJg==
X-Google-Smtp-Source: ABdhPJyRS8LuIOxeZsIQW7aTMGVRK0Ph4X5yUBJ8354EvpwmhPb6OLkvY8F7e5IU4191BSlhW9JvtA==
X-Received: by 2002:a2e:958d:: with SMTP id w13mr5811033ljh.204.1604922728699;
        Mon, 09 Nov 2020 03:52:08 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i4sm1752128lfd.190.2020.11.09.03.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:52:07 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 76842102840; Mon,  9 Nov 2020 14:52:09 +0300 (+03)
Date:   Mon, 9 Nov 2020 14:52:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
Message-ID: <20201109115209.rwhoe4zttaxirx6c@box>
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
 <20201103222013.hypmzlq7uuqufe76@box>
 <71dc852e52bfeafc8c03a6fa3cd5f3cdd4eb6609.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71dc852e52bfeafc8c03a6fa3cd5f3cdd4eb6609.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 04:58:14PM -0500, Lyude Paul wrote:
> ACK, I will send out a patch for this asap

Any update. AFAICS, v5.10-rc3 is still buggy.

-- 
 Kirill A. Shutemov
