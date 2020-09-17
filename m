Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AEF26DFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgIQPdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbgIQPb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:31:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D085B21D7F;
        Thu, 17 Sep 2020 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600356667;
        bh=U30+WX08+z0cH+/xF7rQVmugpFI0LezQJAfWxTvByC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U797rKEH2HvwkbV3ADZQg0OxTZwqmKKlM2frkeHsI9aiTyOS2Zpxn/Umw664nIHYV
         NO/wrkqH5D08aeWgcCc0IPW9HeAbAkkB2WXKhqahvtZTnYIevwJ5pkZglCX9d8OTqk
         GXRet82GrOnNIBNpDIylW3shnw5VFsVlHbiFInjQ=
Date:   Thu, 17 Sep 2020 17:31:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: fix page selection for noinc reads
Message-ID: <20200917153139.GB711089@kroah.com>
References: <20200917151920.3117566-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917151920.3117566-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 06:19:19PM +0300, Dmitry Baryshkov wrote:
> Non-incrementing reads can fail if register + length crosses page
> border. However for non-incrementing reads we should not check for page
> border crossing. Fix this by passing additional flag to _regmap_raw_read
> and passing length to _regmap_select_page basing on the flag.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 74fe7b551f3385fa585d92616c85b3a575b2b2cb

Please read the submitting patches document for how to properly write
"Fixes:" lines.

Same for patch 2/2.

thanks,

greg kh-
