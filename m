Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1485D2AFEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgKLFeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgKLCk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 21:40:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5D4C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 18:40:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z1so2002191plo.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 18:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H5NGIoEf3hsr/533rkXfzNM1uwzZh6+4t5AMsSdas3U=;
        b=HNDSyXQSjnLI2BH0ng04Ri5AGNMEcJ8SAe8af3AYBftgVVSMACxKasHuvX0lVc21Xw
         km4zxdpsP+ZdBVAua2DcFnDz4i6DlCicowvL1SJ580y4d4r510YJhpQ2ZBtS5gnMMF+g
         oKYbWa4JIRhphigR+9acouc+4EdOG2w9bkiWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H5NGIoEf3hsr/533rkXfzNM1uwzZh6+4t5AMsSdas3U=;
        b=PCgGxjV/E3Wla89jTb9u8CU2+dEsVIa9ZZOmVG2aBRmWP6jLvOLwScLjMp0/4zG2ld
         Ue4yA6ff4M+GYILHWe+RTvlNA5jiIuQtBDzKfRrQtUaTTi63nl29gfexULWJrywGna1M
         nW5hX1GQpZvpVwZVXqfZjKd706CpRsGwoWFN+WLz9GPzdx1+v7iKQSUs3BU0XKlhZKoN
         g6CKL0Ekid5VYqzYQfJRgdS1yKLyiAMApl6GFptEzs1skqkNgNesnvX8Cha0qps+5e+Y
         4N+gY+oi6umZaXASTKmjs9Ne+q2MdrGPyXBJvcJRHvJsii/kmH7Dy3i4YbK06E57f48E
         IEBw==
X-Gm-Message-State: AOAM531P1EK09lOq6+ld+/Vo+ez5m8kuNslpgtujD5ObICnsHqz1gaJK
        Y88avW2qneVKKGC/Vd8niXIjUg==
X-Google-Smtp-Source: ABdhPJzdV08nbtMToPsz5Uhx8XG6Ame9ZNIHUvsXs12YRd+0sGNYtWcKl3DtwDU8dB9GYu1gNx0HNw==
X-Received: by 2002:a17:902:76c5:b029:d6:a399:8231 with SMTP id j5-20020a17090276c5b02900d6a3998231mr24464509plt.3.1605148857242;
        Wed, 11 Nov 2020 18:40:57 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id z7sm4238296pfr.140.2020.11.11.18.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 18:40:56 -0800 (PST)
Date:   Wed, 11 Nov 2020 18:40:55 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 2/2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201112024055.GA1367855@google.com>
References: <20201023214328.1262883-1-pmalani@chromium.org>
 <20201023214328.1262883-2-pmalani@chromium.org>
 <20201110115453.GI1224435@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110115453.GI1224435@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Tue, Nov 10, 2020 at 01:54:53PM +0200, Heikki Krogerus wrote:
> On Fri, Oct 23, 2020 at 02:43:28PM -0700, Prashant Malani wrote:
> 
> I've now come to the conclusion that this is not the correct approach.
> Instead, the whole identity, all six VDOs, should be supplied
> separately with a "raw" sysfs attribute file after all.
> 
> The three attribute files that we already have - so id_header,
> cert_stat and product - can always supply the actual VDO as is,
> regardless of the product type, so they are fine. But these new
> attribute files, product_type_vdoX, would behave differently as they
> supply different information depending on the product type. That just
> does not feel right to me.

OOI: I'd like to understand the reservations around this approach. Can't
userspace just read these and then interpret them appropriately according
to the id_header as well as PD revision (and version number) if that's exposed?
The only thing I see changing is how we name those product_type_vdoX
sysfs files, i.e product_type_vdo0 == passive_cable_vdo OR active_cable_vdo1
depending on the product type.

That said, perhaps I'm missing some aspect of this.

> 
> So lets just add the "raw" sysfs attribute file. We can think about
> extracting some other details from the product type VDOs once the
> specification has settled down a bit and we can be quite certain that
> those details will always be available.
> 
> Would this be OK to you? I think we should be able to dump the data to
> the "raw" sysfs attribute file with something like hex_dump_to_buffer().

FWIW, "raw" option SGTM (the product type VDOs can be parsed from the
buffer since the format is fixed).

> 
> thanks,
> 
> -- 
> heikki
