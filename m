Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF0220688
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 09:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgGOH4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 03:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgGOH4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:56:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92BE12064C;
        Wed, 15 Jul 2020 07:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594799771;
        bh=xZqtc5KFNzDMqv1v9PhQ/sqkiiymDO/f3b/2PSAL50o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGw0rplfw8f/k1FfNUkKQGBVYlQ4xVToAgpgsuO+QQc4bhsaVhcGYzzRY4JJ9ntAd
         zNV9h+ac/XodDn3iDCOTCDexqcuLaaAms7kgL7HE52wKcxqalcNdCRfo2ezryio/s/
         u4Jisz+u01Didj1whBgMfzyt9iKyFRekqJ0R2Dgc=
Date:   Wed, 15 Jul 2020 09:56:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Eric Peers <epeers@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] cros: platform/chrome: Add cros-ec-uart driver for
 uart support
Message-ID: <20200715075607.GA2514306@kroah.com>
References: <20200715074106.1754048-1-bhanumaiya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715074106.1754048-1-bhanumaiya@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:41:06AM -0700, Bhanu Prakash Maiya wrote:
> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> 
> This patch enables uart transport layer for cros_ec framework.
> The cros-ec-uart binds with EC device working on uart transport to
> send request and receive response.
> 
> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Change-Id: Icb23b633700f1ef4d123e3f21fd26fad21a3f207

I think you forgot to run checkpatch.pl on this :(

