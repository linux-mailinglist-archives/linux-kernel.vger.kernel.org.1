Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE82C807B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgK3JAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgK3JAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:00:42 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97803C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:00:02 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so14962661wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UfG2bNla+H193S2roaGiiAOAkRdtKJ6N7UjdzcTnBWo=;
        b=UeHEb5BhuoU0KmWLSE5a7oS+jC3wR+MNje6cxnqJ7NWF+gkq9i9BUlSteOkzUeWEn9
         uMVcMGQQhL3Qx6OxwocPO9S5jI7eyRkaEYSCUgzSnwJM9GkMyEoAx6mKm9QLsuBKCAI0
         q6PvvuiJYfNOCPYTKg8gmNM6K505n86uGyto1sjmR80C+6yQwjQzBft7co7noaufzQsn
         +TD0HP1UYdAFBrrvVQhpFDiPB/y6FcqOY03XiD/6t85NizskJJWXUO5BYeXo8oFXOp80
         adY0SJQcb1v3rlVVSrHDgvpYJAisUJ1SicyTB1S25ItN/SS3MCKPSuk/MirD/XdvvWJr
         zguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UfG2bNla+H193S2roaGiiAOAkRdtKJ6N7UjdzcTnBWo=;
        b=lhnZNjnqeYhJfJKD7wiphiILpRa4dw/zAzxr1hIm3GlkebQzPhyobtwYxyMf36na+a
         YGeWj1MHwzfFuuSTuPjSBbyjf2yjowFN+5nYd9aNso+FWgpDFi1LtS8hDmuegYnepRUL
         zCnVR62anWOpTf+yoB3E+8Yf25dBaTnlYxgrj4MgdKGyPABMoxgiz7gXnMwdFNnlc3w+
         ik78yWXutufeiGxNJ8OZf6lyqVvSyw+9k3XBfs2F9pWnyzoZkoLccV6+I3mt5cH9LIH4
         4saS9JS+5oAleW3GejQSR2M9CEtim9IzHsdKazeBtJNhKQNib2FQgXk1vPklK25QaOn2
         fnaw==
X-Gm-Message-State: AOAM5313r2qPLTU5zQouNjZ0OX3adCfXQd4dqnOS0mBfnY/CSCEuRKsU
        WlvBQTLYBDmUNHMdQKbgdYxrlA==
X-Google-Smtp-Source: ABdhPJwjMD/K9L6q/u1v+6o0Xd7gQBKWZ31ZOPLI5GwYmNcIziyuHNZb8NaF/OUL90PKR/MIdqoYJg==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr27285736wrt.158.1606726801375;
        Mon, 30 Nov 2020 01:00:01 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id c190sm18615729wme.19.2020.11.30.01.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 01:00:00 -0800 (PST)
Date:   Mon, 30 Nov 2020 08:59:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Dany Madden <drt@linux.ibm.com>, Lijun Pan <ljp@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Santiago Leon <santi_leon@yahoo.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        John Allen <jallen@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH 8/8] net: ethernet: ibm: ibmvnic: Fix some kernel-doc
 issues
Message-ID: <20201130085958.GC4801@dell>
References: <20201126133853.3213268-1-lee.jones@linaro.org>
 <20201126133853.3213268-9-lee.jones@linaro.org>
 <20201129191015.GO2234159@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201129191015.GO2234159@lunn.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Nov 2020, Andrew Lunn wrote:

> On Thu, Nov 26, 2020 at 01:38:53PM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  from drivers/net/ethernet/ibm/ibmvnic.c:35:
> >  inlined from ‘handle_vpd_rsp’ at drivers/net/ethernet/ibm/ibmvnic.c:4124:3:
> >  drivers/net/ethernet/ibm/ibmvnic.c:1362: warning: Function parameter or member 'hdr_data' not described in 'build_hdr_data'
> >  drivers/net/ethernet/ibm/ibmvnic.c:1362: warning: Excess function parameter 'tot_len' description in 'build_hdr_data'
> >  drivers/net/ethernet/ibm/ibmvnic.c:1423: warning: Function parameter or member 'hdr_data' not described in 'create_hdr_descs'
> >  drivers/net/ethernet/ibm/ibmvnic.c:1423: warning: Excess function parameter 'data' description in 'create_hdr_descs'
> >  drivers/net/ethernet/ibm/ibmvnic.c:1474: warning: Function parameter or member 'txbuff' not described in 'build_hdr_descs_arr'
> >  drivers/net/ethernet/ibm/ibmvnic.c:1474: warning: Excess function parameter 'skb' description in 'build_hdr_descs_arr'
> >  drivers/net/ethernet/ibm/ibmvnic.c:1474: warning: Excess function parameter 'subcrq' description in 'build_hdr_descs_arr'
> 
> Hi Lee
> 
> It looks like this should be squashed into the previous patch to this
> file.

It certainly looks that way.  Will fix.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
