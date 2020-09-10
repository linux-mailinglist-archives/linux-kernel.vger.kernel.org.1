Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9252644B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 12:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgIJKyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 06:54:02 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38815 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730462AbgIJKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:51:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C82B55C0A9A;
        Thu, 10 Sep 2020 06:51:24 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 10 Sep 2020 06:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=DdELkvR3uhOe2Rhzrj5jKX/YqnGcR3K
        HmymxYMrIwr0=; b=bwWNUjqSAoPCUtNTmgKq9vi0F4MIiEtGqLP0AIpCdQQYFuP
        +va/sK76V3hyAgaBgKVB1qZbAgrhFChgsmY7GNXdvTSco/DIA0c/8l17FxNKuXw2
        YixJJU26EiX0bdynY/HHOLrfukWs38oLWnz2sEyAIRvHTqoDjp2celGkaVIbUfHw
        jo6P5S/fT5KIGqNhmD6E3lMvUWr0Q6fZ3pajCXxuAbMTVAYOQe2ifuxRZZ4oUGd5
        jFWTjR/EVChQhTDNvEOSXDvSji+NL2WyeQgSezm9AhVCP8w+CetYdTMPz4SknjgL
        6HZOsUmyO/oncZdtuU7Hkty8y0aJDPThAfY6OIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DdELkv
        R3uhOe2Rhzrj5jKX/YqnGcR3KHmymxYMrIwr0=; b=KWjQxVuF/Q06Ow3Mcbf/h+
        qmqkUnSHHUHgVIq3g8neQ8lULpyHcxJ1QGcacT8dt3xJmh5UyL5DHGMUDMvh+lVM
        2/as8VgeyuF/bN9f5T62D+NfPMB43u6+VjXfbWSclzqbgumTbXG36I/X6Qu6uIu3
        CfvWY0Q09GUkryw55IrePwL/XtWG1iElWO5pqe1ZiR8/RbSPf8Izi1YtqcQm5KpS
        E9xA6/JNFCua9Au0licTKOD8MJ+vhze1LHRUWG0HQb+m/vREFEBj/aFoEmkEbGrG
        N5Vx3gzIWcTuTvU3O0DVKrZPjhaBdUMBOyyt7KupwjcXr2cacNeJdWGXkkx8wffQ
        ==
X-ME-Sender: <xms:KwVaXyckm96ORkf991PJAkZeQ9ltnBFrxM18eLUiVAjL5eS9BFUNRQ>
    <xme:KwVaX8OKc5iPW6xy0nryYLxxNQ0Dt-rgXLYklZ2SNtnV1oQ3A_9RX6kK5xxu7imX6
    OM_07PAskDHncllwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepgfefffduudeggeekleffieeuteeghfelvddtteekveevgeethfehleeg
    udffffevnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughr
    vgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:KwVaXzifAbXMQSUxz7b0Qqp5JI87CDMF_zcP_OUw_TH8zUtH0JWHQA>
    <xmx:KwVaX_-GQCPL1qFsouYJ0j5JovdSu0NwaV3bHTEKSCHlXcwGqihpPA>
    <xmx:KwVaX-tYGs1GB09LGo-aV5ijxhaxVu-qdKZgF0vVLeHUmfJRFBgjMA>
    <xmx:LAVaXyjhxWjGcUK6Q7rBT56Wk61JbOmLKdjGIiee5RP1JFgL74Ylvg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 50D35E00D8; Thu, 10 Sep 2020 06:51:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-259-g88fbbfa-fm-20200903.003-g88fbbfa3
Mime-Version: 1.0
Message-Id: <1e1dbb10-1628-4498-9ce2-8c4ce79162c8@www.fastmail.com>
In-Reply-To: <92b193b6-7912-1823-ca38-58cf208e68c4@roeck-us.net>
References: <20200910100516.GE12635@kadam>
 <92b193b6-7912-1823-ca38-58cf208e68c4@roeck-us.net>
Date:   Thu, 10 Sep 2020 20:21:02 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Dan Carpenter" <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        linux-hwmon@vger.kernel.org
Cc:     "kbuild test robot" <lkp@intel.com>, kbuild-all@lists.01.org,
        "Jean Delvare" <jdelvare@suse.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus) Expose PEC debugfs attribute
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Sep 2020, at 20:04, Guenter Roeck wrote:
> On 9/10/20 3:05 AM, Dan Carpenter wrote:
> > Hi Andrew,
> > 
> > url:    https://github.com/0day-ci/linux/commits/Andrew-Jeffery/hwmon-pmbus-Expose-PEC-debugfs-attribute/20200910-010642
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
> > config: x86_64-randconfig-m001-20200909 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > smatch warnings:
> > drivers/hwmon/pmbus/pmbus_core.c:2415 pmbus_debugfs_ops_pec_open() warn: '0x' prefix is confusing together with '%1llu' specifier
> > 
> > # https://github.com/0day-ci/linux/commit/705b8b5588d4102256d0954086ed16c9bdf9804f
> > git remote add linux-review https://github.com/0day-ci/linux
> > git fetch --no-tags linux-review Andrew-Jeffery/hwmon-pmbus-Expose-PEC-debugfs-attribute/20200910-010642
> > git checkout 705b8b5588d4102256d0954086ed16c9bdf9804f
> > vim +2415 drivers/hwmon/pmbus/pmbus_core.c
> > 
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2391  static int pmbus_debugfs_set_pec(void *data, u64 val)
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2392  {
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2393  	int rc;
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2394  	struct i2c_client *client = data;
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2395  
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2396  	if (!val) {
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2397  		client->flags &= ~I2C_CLIENT_PEC;
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2398  		return 0;
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2399  	}
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2400  
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2401  	if (val != 1)
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2402  		return -EINVAL;
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2403  
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2404  	rc = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2405  	if (rc < 0)
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2406  		return rc;
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2407  
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2408  	if (!(rc & PB_CAPABILITY_ERROR_CHECK))
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2409  		return -ENOTSUPP;
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2410  
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2411  	client->flags |= I2C_CLIENT_PEC;
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2412  
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2413  	return 0;
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2414  }
> > 705b8b5588d410 Andrew Jeffery 2020-09-09 @2415  DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_pec, pmbus_debugfs_get_pec,
> > 705b8b5588d410 Andrew Jeffery 2020-09-09  2416  			 pmbus_debugfs_set_pec, "0x%1llu\n");
> >                                                                                                  ^^^^^^^
> > Was the 1 intentional?  Anyway, you probably want to remove the 0x so
> > it doesn't look like hex.
> > 
> 
> Nice catch; I didn't notice the 1. It is still there in v2, but it does 
> seem quite useless.

Do you want to just rebase it out, or would you like me to send
a patch removing the stray 1 from v2?

Andrew
