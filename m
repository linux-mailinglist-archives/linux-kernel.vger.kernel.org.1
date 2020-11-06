Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251C42A930A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgKFJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgKFJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:45:37 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E82C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:45:35 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c20so814117pfr.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zgVfc4epwEVsBy5D1AlUoYufK2pJ7jZPil3bBJ0ToF4=;
        b=m/pgJcyWvpgkbl+Udmn/zdof1pLjxbbEEp1pJkBFpKCJ9R2DsOQeoBN26YdgKznIxJ
         eKoxq0aVJTZE0WIb0FteLoh8t65lfR6HNJesAm0aIccIY28IKNUptNvwxmeztAv4hL5x
         sEDmhQLx8u353eEhU3iZtFnkKJ0QOTT3I0sbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zgVfc4epwEVsBy5D1AlUoYufK2pJ7jZPil3bBJ0ToF4=;
        b=JS7SJk+Ufcz1c/LBESKoCZlyRREmqyCUF0qg6mqtxcFeI/bCx0UM/7KdspIum/fI/l
         yVd06B6nvlXInoEP7APFNu4qvoa5nuw8H1a5jRA2l+u4rutRNIzPTudt0Y9IBRKsBZHf
         htN8ipBZZn+WhXRy/m+txwnGEBexzxt/Ta0+9/DVeMGLczwSN5xpUjt9DEIAImEnbXnc
         YkO4FT08J61/5BIIWNB3NiNHjGuoWiEtG8w8tSeq7rNdoxGtq54ltG8ZvwJAf/QtGHML
         qgH/qym+BhvF+cTg8ueZdz3j7Ibljkpt/NU6FLQ5Jc4VYdUWDXb4Y2UmO7qGd5WGguvO
         DPjw==
X-Gm-Message-State: AOAM533rfWfa5NwPQZeIelfn0kXeKIXOD7v0l1yCMI99M5ox2aIt7z8J
        7PfIw4LfflZRK64Yb7b0U0gj+w==
X-Google-Smtp-Source: ABdhPJwjy4FnXBN7q9t3B3vjzFR5efrhhh4bKy8ZzGsKjVyZNKNN/E9/0s/8oei2zEkyqzkLvr9Z1Q==
X-Received: by 2002:a63:1519:: with SMTP id v25mr1036774pgl.2.1604655935179;
        Fri, 06 Nov 2020 01:45:35 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id g16sm1619530pju.5.2020.11.06.01.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 01:45:34 -0800 (PST)
Date:   Fri, 6 Nov 2020 01:45:33 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        dzigterman@chromium.org, alevkoy@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 6/6] platform/chrome: cros_ec_typec: Store cable plug type
Message-ID: <20201106094533.GB823981@google.com>
References: <20201106012758.525472-1-pmalani@chromium.org>
 <20201106012758.525472-7-pmalani@chromium.org>
 <20201106072059.GA2614221@kroah.com>
 <20201106085907.GA823981@google.com>
 <20201106093302.GA2637814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106093302.GA2637814@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Nov 06, 2020 at 10:33:02AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 06, 2020 at 12:59:07AM -0800, Prashant Malani wrote:
> > Hi Greg,
> > 
> > Did you not receive these?
> 
> Ah, I got 1, 2, and 5, and now 6.  That's confusing, think about if you
> were to receive such a series, what would you think to do with it?
> 

Yeah, I agree it looks confusing. Sorry about that.

> > > So you save it but what happens with the value?
> > 
> > The type C connector class framework exposes it via syfs to user-space when we
> > register the cable via typec_register_cable() in patch 4/6 [2].
> 
> So you added a new sysfs file and api without updating
> Documentation/ABI/?  That's not good :(

This is a pre-existing API[1] and sysfs file[2] so we are using those
and not adding anything new.

[1]:
https://www.kernel.org/doc/html/latest/driver-api/usb/typec.html#c.typec_register_cable
[2]: https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-typec
(see /sys/class/<port>-cable/plug_type)


Best regards,
