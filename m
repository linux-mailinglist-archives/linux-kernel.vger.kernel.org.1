Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFBB281B5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbgJBTLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbgJBTLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:11:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F048DC0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 12:10:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id p21so1471557pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tg1cbAlOlGYiJsswqBh0RLPlIwGpk0pFK93ZlIvhFT0=;
        b=M8KFg280855rVx0KEWeBj/BfCJrMcDd9RMYKRAqs4qIeVPASe/w8qh2Lqjxpktz4Ex
         iLRwJUqNM5YGLD4lrmCUdDnNQCk3D8E6TB2bndWkGrWzXPsfYItN/buUavomh9zIC6VP
         xkjfNUIR13DOvZBrvMZXxY2HcsEAsER336fgZl4bi31huPInbkMV+FAiUMpf1sKNI4y/
         7n633Ah7jdgYqVq4AEto3YIWGvbNvteFMCNRfJZ/I0NCjUGvX2KhOf9cRwYcn5VB3wRl
         IgMUJYxjlnPd1QfjtN/q6qJaS2WC1ZmTGT6RN29PC3jpVq8VYLHHa279TEYNFOCg8fls
         d40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tg1cbAlOlGYiJsswqBh0RLPlIwGpk0pFK93ZlIvhFT0=;
        b=YMIRnGwFE1Ku5JS53KwcZdizqkPgr0CfZDhMqFUNnOM5jrm5MLTDAZuxZwpfRSwpAg
         sT0oAL/1kX6XHwbHL4VuH64ZEYwJ6NAZynQusC1rOjO/Pxvb//ElwT1B5RFunAncDMhA
         v/voHNtLum6gLHW89igMJlKKX8ajCaJV/wZXh846KAuzj8ftAwTbao/aq4Bh9Ovy99uX
         L3C7LnqN5b6NsUjCRiUCO+ZdzpC/LPq3TPhLicMlKa9DK7Wqn6pjKjm9UdOZTFuG8hfh
         YZ/e0Ae8fujkCCM5fpm+s6beKtKLRJCuk/xWsMKXU2jySsW7fwxRo5OqvWK23FOIzFbU
         cw2Q==
X-Gm-Message-State: AOAM530FTP3Kx8+6QQHDs3yYemrdYHfhUZARKcHEpWBvREj+u4+H5Bx5
        xy0D2ffohM/mPl4p3KdTBL8eHA==
X-Google-Smtp-Source: ABdhPJz6O93ojd0dzFKataI3JpLuelW/Y11niXA0RRE13MJ0/Otw6VWv+yAgkUeYwsZUAkSr+ytqtg==
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr4245263pjx.119.1601665859439;
        Fri, 02 Oct 2020 12:10:59 -0700 (PDT)
Received: from hermes.local (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id t5sm2407080pgs.74.2020.10.02.12.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 12:10:59 -0700 (PDT)
Date:   Fri, 2 Oct 2020 12:10:51 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jarod Wilson <jarod@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] bonding: update Documentation for
 port/bond terminology
Message-ID: <20201002121051.5ca41c1a@hermes.local>
In-Reply-To: <20201002174001.3012643-6-jarod@redhat.com>
References: <20201002174001.3012643-1-jarod@redhat.com>
        <20201002174001.3012643-6-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Oct 2020 13:40:00 -0400
Jarod Wilson <jarod@redhat.com> wrote:

> @@ -265,7 +265,7 @@ ad_user_port_key
>  	This parameter has effect only in 802.3ad mode and is available through
>  	SysFs interface.
>  
> -all_slaves_active
> +all_ports_active

You can change internal variable names, comments, and documentation all you want, thats great.

But you can't change user API, that includes:
   * definitions in uapi header
   * module parameters
   * sysfs file names or outputs

