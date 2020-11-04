Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131F12A6C2A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgKDRtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDRtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:49:20 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD79DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 09:49:19 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 133so17894927pfx.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 09:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6DcXk+MfzqX1VYgKu6yCxw6DUdWo+h55xJMrIphl6v0=;
        b=l8mgNMwn/m61nxiUfrS08uJ9lmAaaEF3bw3gbxTR+yd8gLCfNo8VkjWEUWal57/oav
         DU4e7/UZbPxEOpG0LmHYKfym9jzUPRQ3J4YUdcvMQ7GyLNn1NyHZAbmqMgTJHHvUBhwN
         DMp7Uzpho85QpnoNaJntK9tg17yEwmbDtyWeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6DcXk+MfzqX1VYgKu6yCxw6DUdWo+h55xJMrIphl6v0=;
        b=Q3c3B9jAXQHch18wit23UMbKV5gYBWZbjKol3Z4L+IKuSi1GravLvSL5qSWzVn+Lob
         Us379TJdHHce01357343Ct+Vpp1cdpU4T1WECZZnakpjb8TQlYNYZ+U0EO+qmIEH8IWO
         +hKr4RV28s51wqsMk2WWVqCQhNEc2w4P6Ucvt/6/12lPU19mdkBnsH8/ZZmK65L7clvM
         ejCGFYx7BKvMTkpRlAWEwoOZScNJPZ0IpJXbDFzwSNfiNmMQcrd+XI18LYFsH+6miKL4
         Gn0ys9GPHvmPjdT7F5yfm84QY8NctKWaJZYpzEsJOWe1R/MfthUwR3OxV7EsoiQx/TxT
         v3zA==
X-Gm-Message-State: AOAM533kYfneyN37q2docziKMdmDAPDphOx/8aEnHsZeBN2nsWC4tNe0
        sRbCZbp+uPYtuCBfBtSDpAhsKNWNf5E1RA==
X-Google-Smtp-Source: ABdhPJx0dx/aveFsSHxCgcTEcAQc9HAgWMP5UBSvfwmC5gtlK5I5oG/MTu9LaA6X+XTTLVQGaUeetg==
X-Received: by 2002:a17:90b:3902:: with SMTP id ob2mr5437810pjb.109.1604512159187;
        Wed, 04 Nov 2020 09:49:19 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id d4sm2967693pjj.45.2020.11.04.09.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:49:18 -0800 (PST)
Date:   Wed, 4 Nov 2020 09:49:17 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3 2/2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201104174917.GC3913249@google.com>
References: <20201023214328.1262883-1-pmalani@chromium.org>
 <20201023214328.1262883-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023214328.1262883-2-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Was wondering if there were any comments on v3 of this series?

Best regards,

-Prashant
On Fri, Oct 23, 2020 at 02:43:28PM -0700, Prashant Malani wrote:
> A PD-capable device can return up to 3 Product Type VDOs as part of its
> DiscoverIdentity Response (USB PD Spec, Rev 3.0, Version 2.0, Section
> 6.4.4.3.1). Add sysfs attributes to expose these to userspace.
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
