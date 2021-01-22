Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C656630047D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbhAVNrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:47:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:55829 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbhAVNrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:47:03 -0500
IronPort-SDR: 2NdTQOoGJgwZf9wZcY21UVnP2tV5plDiHT3ESNTF45XeFoJm5TuopibxWQBcw2vQkrqbJ5O3Ac
 zOH0+p2lGddw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="240987505"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="240987505"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 05:45:17 -0800
IronPort-SDR: 0/foKXnvR34jt59wd4PnlyGaMdhteOUh3++ZFCn5ggaHfd83ywXXNc7dLhVq3O8RoPRUT4DLRW
 jsh4+RdhvcQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="357030969"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jan 2021 05:45:15 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1] misc: pti: Remove driver for deprecated platform
In-Reply-To: <20210122114358.39299-1-andriy.shevchenko@linux.intel.com>
References: <20210122114358.39299-1-andriy.shevchenko@linux.intel.com>
Date:   Fri, 22 Jan 2021 15:45:14 +0200
Message-ID: <87im7pjdat.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> Intel Moorestown and Medfield are quite old Intel Atom based
> 32-bit platforms, which were in limited use in some Android phones,
> tablets and consumer electronics more than eight years ago.
>
> There are no bugs or problems ever reported outside from Intel
> for breaking any of that platforms for years. It seems no real
> users exists who run more or less fresh kernel on it. The commit
> 05f4434bc130 ("ASoC: Intel: remove mfld_machine") also in align
> with this theory.
>
> Due to above and to reduce a burden of supporting outdated drivers
> we remove the support of outdated platforms completely.
>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

FWIW,

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Regards,
--
Alex
