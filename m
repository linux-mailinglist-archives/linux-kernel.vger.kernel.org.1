Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4F12D0245
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 10:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgLFJgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 04:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgLFJgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 04:36:33 -0500
Date:   Sun, 6 Dec 2020 10:36:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607247346;
        bh=dnR5dwJKbsSPtTsm2TDWHrwzN1RLBDzrpTl/WUpJhfQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijvKcuTqh/E0XKwrajrMzPh1pAYyHvet56O0QWxW38lxT4y99XLIk3oU4GW3ZVi9i
         S2r3qkWCLO4kfeOo0Zr0nXgWZnqs7m/hj5G0Dqm3EWV1jZEJgmVaV6SM4gtq/Na6Bx
         CR1RpfHY56Ihew6OPmd07SmJkq0N1WyrPrI8Vq4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Wang Yu <yu1.wang@intel.com>, Liu Shuo <shuo.a.liu@intel.com>
Subject: Re: [PATCH] Revert "mei: virtio: virtualization frontend driver"
Message-ID: <X8ymO1vqGdMo7Uj1@kroah.com>
References: <20201205193625.469773-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205193625.469773-1-mst@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 02:38:46PM -0500, Michael S. Tsirkin wrote:
> This reverts commit d162219c655c8cf8003128a13840d6c1e183fb80.
> The device uses a VIRTIO device ID out of a not-for-production
> range. Releasing Linux using an ID out of this range will make
> it conflict with development setups. An official request to
> reserve an ID for an MEI device is yet to be submitted
> to the virtio TC, thus there's no chance it will be reserved
> and fixed in time before the next release.
> 
> Once requested it usually takes 2-3 weeks to land in the spec, which
> means the device can be supported with the official ID in the next Linux
> version if contributors act quickly.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Now applied, thanks.

greg k-h
