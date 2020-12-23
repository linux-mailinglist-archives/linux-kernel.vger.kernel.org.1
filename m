Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA32E1E73
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgLWPlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbgLWPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:41:25 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F12C061285;
        Wed, 23 Dec 2020 07:40:45 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j12so15314498ota.7;
        Wed, 23 Dec 2020 07:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Wiq5FgkNEMxTeNNHguYsV5m8V7ZroVN8cO5RrKewIw=;
        b=huDDDzEOGpCU46nPfJjLVwoCGQTj1nhXACMxp7IIxY997P14eBvWYSAvh3q6DO6zcq
         Tg1dCjTntKYqv/H8y8+49bSkX3Nf4pxpAijXhTKXG38oTkkcTHM58P5aVtpLd0t88uKe
         WD5D8Ay2qNVulvW+m2sbOpR/WwAdMHZnfjiJ6MhqmLR9Pbx+Sb9zSiT1wZl7l1owqZYO
         k046R0l7191XjtWxv+PEySTs+WA6svXVefdAQnBLc20hrFM810uP3kKhCOZsGj8ZKhwO
         CcvvVt0m3FSuR31oinazDy7XnsU7UL5QX6SNDdxiBeXH2Wbz5o8BFZ3vktzltY0AAdPQ
         Ph1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Wiq5FgkNEMxTeNNHguYsV5m8V7ZroVN8cO5RrKewIw=;
        b=YuA+z8LJPcfZCbHcWnnjK0hzgJrHunU0qhih2W8Ysg47eeFxZNuK0f1Dx8LeYNkjEI
         HYygjr8rmN6eMTIQ0/EVAHrfSU9x09v1xkBdDv1PmEJoGk8ErMq9wwEeSv66dhCdmJ4A
         gN34/Vg2dd8kySfgTCTrSEEKGJFkfoH1EFDlcK9QL8uiRn7dTkn/PDuFJvHJimo7jvo7
         kIb9/zSIpjxrKy9HkMi73hWNg5CE3Vt5AhzZ9o4nVdd0tlOPpKly6nTxLtNARRrYWAzm
         zqmYpLKz1bgHUZ+XAj1VP0UfT/aoQ0r0fapQ0vMLEQ3aWjny9Z6kSzFS/F9SsUAN1Png
         3fqg==
X-Gm-Message-State: AOAM531Xi6ZM9ang1oUMk7Jo2SB+zwdbNnIwMmNkySI7rszNUDMMrL2K
        zEetAGrC35i3gtET1t2idNY=
X-Google-Smtp-Source: ABdhPJwgFXiJRJqKOFKWcMCXO/N8H/wWJB7WcEJHNNu8zAbsxuBPxsUw+SVJePqSCgqknXHz+GqCsw==
X-Received: by 2002:a9d:7407:: with SMTP id n7mr19636507otk.189.1608738044790;
        Wed, 23 Dec 2020 07:40:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b19sm3133837oib.6.2020.12.23.07.40.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Dec 2020 07:40:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Dec 2020 07:40:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, bjwyman@gmail.com
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus/ibm-cffps) Set the
 PMBUS_NO_CAPABILITY flag
Message-ID: <20201223154042.GA65400@roeck-us.net>
References: <20201222152640.27749-1-eajames@linux.ibm.com>
 <20201222152640.27749-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222152640.27749-3-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 09:26:40AM -0600, Eddie James wrote:
> Several power supplies supported by the IBM CFFPS driver don't
> report valid data in the CAPABILITY register. This results in PEC
> being enabled when it's not supported by the device, and since
> the automatic version detection might fail, disable use of the
> CAPABILITY register across the board for this driver.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter
