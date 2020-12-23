Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1EF2E1EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgLWPnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbgLWPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:41:02 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE84C061794;
        Wed, 23 Dec 2020 07:40:22 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id r9so1453419otk.11;
        Wed, 23 Dec 2020 07:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4J0e8dCZT1+opoNSvct2LXMp03w7vCDo/SlgL8IN1WU=;
        b=AoBCwFmRSVOf9JYrBbryNbiDtlLt0iRYzGcmqO5NbmiG++OrHm7zSZZ0GsIrD+VUaM
         87OsnRWPD2xeFDQcjlWwxmbCpxMDWfAOvwqIYPxo/3k0anmikibRVo861G4L+hzDSFkF
         hEld8mOg1UrCUHhu7y6+qOOTdEZm7LGr0GJ6kaN33jEcw19CwEoL1v46Rl7ZB2HmwQCo
         FDlPPcLKvmOdBTtjgosc51tMx4+EzQyVBE/yQBt5YQWnFZmJ4rxmMaJkK4Serc2HFGVO
         ggV8ObQvCN9h/RpFxDyvsSyAKII99brL4FbFHNtJPrQehN10h0O6zCeRcdHV3Ugsf6oU
         W9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4J0e8dCZT1+opoNSvct2LXMp03w7vCDo/SlgL8IN1WU=;
        b=oIfgy38+s/nSKXii/hygiLnEeYOoIwOm4hMo/xKvtZRXUiIO5I5SkogAJ9mvWnI241
         K8XGYUF5FkKGqXYCbiEgArwl8vCgUPRZohOEXw6ycYlkXYP6eWvQE78ZeSZwi/0IvA42
         dpOvAqNi+2CoUC+kmXxHWGeY3e5fCgKAPPfWNSlys01pq+4CmoI08hPFyqZghgOBUPoS
         BpV7EPUE1Tp0Y0zZdpeOcsv0Bm9xROp+7fkcjjXayHuUUWo5FKgI09MG5YIGZPsPMDd+
         MjQAj3ibPmtTzInyYlHDxm8PHiGF1NOF89is+KV24ixuPR+8VhAtYYnxlauEiw20Yzvj
         +PZg==
X-Gm-Message-State: AOAM530Df2uguBm4hrv3Z4mXymDioORTGJg4Np7u4z/yfDJwIASdgR5g
        rXQE5ni+qFrEfpynYizGN7tZBQ1/Eqg=
X-Google-Smtp-Source: ABdhPJy/ungh9vPeAI7+PQycrXlwuYQTXMqXeMhfPmFXie6satLojPy+d9OTEeke8S6YNgfEdH54mQ==
X-Received: by 2002:a9d:518a:: with SMTP id y10mr19535885otg.225.1608738021847;
        Wed, 23 Dec 2020 07:40:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q77sm5375464ooq.15.2020.12.23.07.40.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Dec 2020 07:40:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Dec 2020 07:40:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, bjwyman@gmail.com
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus) Add a PMBUS_NO_CAPABILITY platform
 data flag
Message-ID: <20201223154019.GA65369@roeck-us.net>
References: <20201222152640.27749-1-eajames@linux.ibm.com>
 <20201222152640.27749-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222152640.27749-2-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 09:26:39AM -0600, Eddie James wrote:
> Some PMBus chips don't respond with valid data when reading the
> CAPABILITY register. Add a flag that device drivers can set so
> that the PMBus core driver doesn't use CAPABILITY to determine it's
> behavior.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter
