Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB102E96FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbhADORK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbhADORK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:17:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7700E20770;
        Mon,  4 Jan 2021 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609769789;
        bh=y/LXBcq9VDQBuYwzWme/oeAub9WB92dP95zKP549HqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gv7fwHQQ9629vI7b3Z2OGlYwtPBQDfrUqpysno2N1M44QmI0C1v1R5iVbv9idBKSE
         tqk3pCzaBMon74AIr6MiV83iSutbQwzlyr8k63r60t97dJTjxI7yt+Q6qe/cHRUiZy
         2jpNtLMZ/c09CdjfxnQyErfWIZGXp8MTWL9Kuomo=
Date:   Mon, 4 Jan 2021 15:17:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Xiaolei Wang <xiaolei.wang@windriver.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Lechner <david@lechnology.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: Re: [PATCH 1/2] regmap: debugfs: Delete a misplaced pointer check in
 regmap_debugfs_init()
Message-ID: <X/MjlO6jwJWFfQmU@kroah.com>
References: <20201229105046.41984-1-xiaolei.wang@windriver.com>
 <d516efdd-7e66-13fe-3798-cdea5ff012dc@web.de>
 <PH0PR11MB5077EC74C0A81ABF8F082BC795D70@PH0PR11MB5077.namprd11.prod.outlook.com>
 <d463ff8b-306d-6f40-9115-1595d69edc95@web.de>
 <PH0PR11MB507731B129639CED3B8C753595D70@PH0PR11MB5077.namprd11.prod.outlook.com>
 <932c5921-9ad3-e37b-5f31-4de69fa0ca8b@web.de>
 <81f33869-32f6-650f-0f06-e2a5dce57236@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f33869-32f6-650f-0f06-e2a5dce57236@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 03:12:33PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 4 Jan 2021 13:43:01 +0100

This does not belong in a changelog body of a patch :(

