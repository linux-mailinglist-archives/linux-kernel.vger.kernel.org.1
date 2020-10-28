Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF1E29E070
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbgJ2BWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbgJ1WEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:04:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F831C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:04:55 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p10so1066341ile.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tKIGBxSmn3rugAetd5KJVZleOctBFQ6YAeyg0+yYtzE=;
        b=hLp75HXJoi1yVHo2at7snNjLCNnkf4+5rvP+rOIxyDFecNu+TcGWs7XcvBLLyeiVWS
         ObEdXXZwd+pRAPOf0hAobEAQBun9Ep55XE0GPdpGMg/JnvKjKFuSl5XUk4GybIBi69Jv
         QjhQG1Lnnywc4X/29FZnymNiTtNLhbEYaDAo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKIGBxSmn3rugAetd5KJVZleOctBFQ6YAeyg0+yYtzE=;
        b=jSOSiGDq/gL2t4vokY2R90PC0PKlgxL5On8WIzE3UhpySbe9MVGgIsm4Aa9Fmfsw+l
         LFdK4tAwsl6LX0sx7c1wT+19ToOexcxuVhluhEHYKTf586hebKAeZhVbeNt/9YCLoLJ5
         C52TaNz0lskW084isCfeWBQdAhOcmH5U6sUs3g0eT0nuR99jVnr47aUZrV+QFGu8L4bp
         E10lytwVFANjDjy0ZHLMZ3nrXb1p45qYePokAWsGlhqy7zsvaLSwYV4siSgpNDeVhYP9
         RMvq/iM/0TJ4JMWfnkZVV3atgjbBRS6/Sut59iPQ9JMLR5UkwnVlEU58gICOdViDQ0le
         7nWw==
X-Gm-Message-State: AOAM530EH7u1X4EJkeKdx5JYvdPHNTtBSn5oe6SJNC5xCMWApNQKH/SP
        LWl6tnMg+uFjnUka6NkTOTrX8xJ858xk0Q==
X-Google-Smtp-Source: ABdhPJzPnmAOHD666ZXlTSGi73YgwNi4o3QFVIcpQxGvEhWNHg5HlgamAoVC/hiqM0BDPWMv48r4qg==
X-Received: by 2002:a63:6c09:: with SMTP id h9mr953122pgc.214.1603915897192;
        Wed, 28 Oct 2020 13:11:37 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id n6sm222409pjj.34.2020.10.28.13.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:11:36 -0700 (PDT)
Date:   Wed, 28 Oct 2020 13:11:35 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 6/7] platform/chrome: cros_ec_typec: Parse partner PD ID
 VDOs
Message-ID: <20201028201135.GA3913249@google.com>
References: <20201021205317.708008-1-pmalani@chromium.org>
 <20201021205317.708008-7-pmalani@chromium.org>
 <20201028131633.GA2026875@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028131633.GA2026875@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thanks a lot for reviewing the patch!

On Wed, Oct 28, 2020 at 03:16:33PM +0200, Heikki Krogerus wrote:
> > +
> > +	/* Copy the remaining identity VDOs till a maximum of 6. */
> > +	for (i = 3; i < sop_disc->identity_count && i < VDO_MAX_OBJECTS; i++)
> > +		port->p_identity.vdo[i - 3] = sop_disc->discovery_vdo[i];
> 
> Why do you need to put the product type VDOs in reverse order?

The Chrome EC returns all the Identity VDOs as an array of 6 VDOs (the
discovery_vdo[] array). The first three entries are assigned to the
pd_identity.{id_header,cert_stat,product} members.

This for loop assigns the next three discovery_vdo entries (i.e indices
3-5) to pd_identity.vdo[0-2] respectively.

The "i-3" is because discovery_vdo[3] corresponds to pd_identity.vdo[0]
and so on.

Does that help to clarify the for loop?

Best regards,

Prashant
