Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C127170A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgITS3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:29:12 -0400
Received: from mx.treblig.org ([46.43.15.161]:45194 "EHLO mx.treblig.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgITS3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:29:11 -0400
X-Greylist: delayed 2335 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 14:29:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=Nj9LaSPjGmfv9JN+mSsTBb2RvPhOQvtmvYfxU2tizYY=; b=LrSrmBzYUENgaP+A9IEa2ublAD
        kEmwO/ooYVYEhMCA1qaWuCmYwl2POURqXXjAHAHnhy9fMfupT17SX/9H5L2tQg1mfa6CYEHufUaNP
        46hIKbH4T3/M89Q7q/hVyeSDPTc4yGZMOcKUrH0T3ZLByNymbq16HbhNvliGONrgsEG1qyHMRoMzF
        Lt+EbOdsfpKTSgiOtIs14/5M7tZuTpzGzQDnu+Ws6j9VKZDtGWEbq9znJIMYkK95OWjg3adok9COr
        h1g+o/T5JFO+avpHsGUyBTc3VSMExDDZSap30n7y3JIdBLNkHzoBTSfeoSCqZO4W7oziFpOH/QIP1
        LR25S0yA==;
Received: from dg by mx.treblig.org with local (Exim 4.92)
        (envelope-from <dg@treblig.org>)
        id 1kK3TG-0000Ju-N4; Sun, 20 Sep 2020 18:49:54 +0100
Date:   Sun, 20 Sep 2020 18:49:54 +0100
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [CRM114spam]: drivers/hwmon/w83627ehf.c:2417 w83627ehf_probe()
 warn: 'res->start' not released on lines: 2412.
Message-ID: <20200920174954.GA25438@gallifrey>
References: <20200917094137.GL4282@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917094137.GL4282@kadam>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/4.19.0-5-amd64 (x86_64)
X-Uptime: 18:47:27 up 385 days, 18:08,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dan Carpenter (dan.carpenter@oracle.com) wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5925fa68fe8244651b3f78a88c4af99190a88f0d
> commit: 266cd5835947d08b7c963b6d9d9f15d9e481bd0a hwmon: (w83627ehf) convert to with_info interface
> config: i386-randconfig-m021-20200916 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/hwmon/w83627ehf.c:2417 w83627ehf_probe() warn: 'res->start' not released on lines: 2412.
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=266cd5835947d08b7c963b6d9d9f15d9e481bd0a
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout 266cd5835947d08b7c963b6d9d9f15d9e481bd0a
> vim +2417 drivers/hwmon/w83627ehf.c
> 
> 6c931ae1c09a96 drivers/hwmon/w83627ehf.c     Bill Pemberton         2012-11-19  2015  static int w83627ehf_probe(struct platform_device *pdev)
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2016  {
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2017  	struct device *dev = &pdev->dev;
> a8b3a3a53f9a81 drivers/hwmon/w83627ehf.c     Jingoo Han             2013-07-30  2018  	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2019  	struct w83627ehf_data *data;
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2020  	struct resource *res;
> 03f5de2bb7125e drivers/hwmon/w83627ehf.c     Jean Delvare           2011-10-13  2021  	u8 en_vrm10;
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2022  	int i, err = 0;
> 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2023  	struct device *hwmon_dev;
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2024  
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2025  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2026  	if (!request_region(res->start, IOREGION_LENGTH, DRVNAME)) {
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2027  		err = -EBUSY;
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2028  		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2029  			(unsigned long)res->start,
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2030  			(unsigned long)res->start + IOREGION_LENGTH - 1);
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2031  		goto exit;
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2032  	}
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2033  
> 32260d94408c55 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-03-12  2034  	data = devm_kzalloc(&pdev->dev, sizeof(struct w83627ehf_data),
> 32260d94408c55 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-03-12  2035  			    GFP_KERNEL);
> e7e1ca6ef4f331 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-04  2036  	if (!data) {
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2037  		err = -ENOMEM;
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2038  		goto exit_release;
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2039  	}
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2040  
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2041  	data->addr = res->start;
> 9a61bf6300533d drivers/hwmon/w83627ehf.c     Ingo Molnar            2006-01-18  2042  	mutex_init(&data->lock);
> 9a61bf6300533d drivers/hwmon/w83627ehf.c     Ingo Molnar            2006-01-18  2043  	mutex_init(&data->update_lock);
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2044  	data->name = w83627ehf_device_names[sio_data->kind];
> 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2045  	data->kind = sio_data->kind;
> 3300fb4f886880 drivers/hwmon/w83627ehf.c     Jean Delvare           2012-11-05  2046  	data->bank = 0xff;		/* Force initial bank selection */
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2047  	platform_set_drvdata(pdev, data);
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2048  
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2049  	/* 627EHG and 627EHF have 10 voltage inputs; 627DHG and 667HG have 9 */
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2050  	data->in_num = (sio_data->kind == w83627ehf) ? 10 : 9;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2051  	/* 667HG, NCT6775F, and NCT6776F have 3 pwms, and 627UHG has only 2 */
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2052  	switch (sio_data->kind) {
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2053  	default:
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2054  		data->pwm_num = 4;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2055  		break;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2056  	case w83667hg:
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2057  	case w83667hg_b:
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2058  	case nct6775:
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2059  	case nct6776:
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2060  		data->pwm_num = 3;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2061  		break;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2062  	case w83627uhg:
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2063  		data->pwm_num = 2;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2064  		break;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2065  	}
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2066  
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2067  	/* Default to 3 temperature inputs, code below will adjust as needed */
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2068  	data->have_temp = 0x07;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2069  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2070  	/* Deal with temperature register setup first. */
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2071  	if (sio_data->kind == nct6775 || sio_data->kind == nct6776) {
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2072  		int mask = 0;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2073  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2074  		/*
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2075  		 * Display temperature sensor output only if it monitors
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2076  		 * a source other than one already reported. Always display
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2077  		 * first three temperature registers, though.
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2078  		 */
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2079  		for (i = 0; i < NUM_REG_TEMP; i++) {
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2080  			u8 src;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2081  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2082  			data->reg_temp[i] = NCT6775_REG_TEMP[i];
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2083  			data->reg_temp_over[i] = NCT6775_REG_TEMP_OVER[i];
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2084  			data->reg_temp_hyst[i] = NCT6775_REG_TEMP_HYST[i];
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2085  			data->reg_temp_config[i] = NCT6775_REG_TEMP_CONFIG[i];
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2086  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2087  			src = w83627ehf_read_value(data,
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2088  						   NCT6775_REG_TEMP_SOURCE[i]);
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2089  			src &= 0x1f;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2090  			if (src && !(mask & (1 << src))) {
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2091  				data->have_temp |= 1 << i;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2092  				mask |= 1 << src;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2093  			}
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2094  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2095  			data->temp_src[i] = src;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2096  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2097  			/*
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2098  			 * Now do some register swapping if index 0..2 don't
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2099  			 * point to SYSTIN(1), CPUIN(2), and AUXIN(3).
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2100  			 * Idea is to have the first three attributes
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2101  			 * report SYSTIN, CPUIN, and AUXIN if possible
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2102  			 * without overriding the basic system configuration.
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2103  			 */
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2104  			if (i > 0 && data->temp_src[0] != 1
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2105  			    && data->temp_src[i] == 1)
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2106  				w82627ehf_swap_tempreg(data, 0, i);
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2107  			if (i > 1 && data->temp_src[1] != 2
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2108  			    && data->temp_src[i] == 2)
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2109  				w82627ehf_swap_tempreg(data, 1, i);
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2110  			if (i > 2 && data->temp_src[2] != 3
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2111  			    && data->temp_src[i] == 3)
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2112  				w82627ehf_swap_tempreg(data, 2, i);
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2113  		}
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2114  		if (sio_data->kind == nct6776) {
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2115  			/*
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2116  			 * On NCT6776, AUXTIN and VIN3 pins are shared.
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2117  			 * Only way to detect it is to check if AUXTIN is used
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2118  			 * as a temperature source, and if that source is
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2119  			 * enabled.
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2120  			 *
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2121  			 * If that is the case, disable in6, which reports VIN3.
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2122  			 * Otherwise disable temp3.
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2123  			 */
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2124  			if (data->temp_src[2] == 3) {
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2125  				u8 reg;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2126  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2127  				if (data->reg_temp_config[2])
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2128  					reg = w83627ehf_read_value(data,
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2129  						data->reg_temp_config[2]);
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2130  				else
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2131  					reg = 0; /* Assume AUXTIN is used */
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2132  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2133  				if (reg & 0x01)
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2134  					data->have_temp &= ~(1 << 2);
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2135  				else
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2136  					data->in6_skip = 1;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2137  			}
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2138  			data->temp_label = nct6776_temp_label;
> 02309ad2b8cbcf drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-03-10  2139  		} else {
> 02309ad2b8cbcf drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-03-10  2140  			data->temp_label = nct6775_temp_label;
> 02309ad2b8cbcf drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-03-10  2141  		}
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2142  		data->have_temp_offset = data->have_temp & 0x07;
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2143  		for (i = 0; i < 3; i++) {
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2144  			if (data->temp_src[i] > 3)
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2145  				data->have_temp_offset &= ~(1 << i);
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2146  		}
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2147  	} else if (sio_data->kind == w83667hg_b) {
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2148  		u8 reg;
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2149  
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2150  		w83627ehf_set_temp_reg_ehf(data, 4);
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2151  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2152  		/*
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2153  		 * Temperature sources are selected with bank 0, registers 0x49
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2154  		 * and 0x4a.
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2155  		 */
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2156  		reg = w83627ehf_read_value(data, 0x4a);
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2157  		data->temp_src[0] = reg >> 5;
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2158  		reg = w83627ehf_read_value(data, 0x49);
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2159  		data->temp_src[1] = reg & 0x07;
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2160  		data->temp_src[2] = (reg >> 4) & 0x07;
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2161  
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2162  		/*
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2163  		 * W83667HG-B has another temperature register at 0x7e.
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2164  		 * The temperature source is selected with register 0x7d.
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2165  		 * Support it if the source differs from already reported
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2166  		 * sources.
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2167  		 */
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2168  		reg = w83627ehf_read_value(data, 0x7d);
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2169  		reg &= 0x07;
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2170  		if (reg != data->temp_src[0] && reg != data->temp_src[1]
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2171  		    && reg != data->temp_src[2]) {
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2172  			data->temp_src[3] = reg;
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2173  			data->have_temp |= 1 << 3;
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2174  		}
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2175  
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2176  		/*
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2177  		 * Chip supports either AUXTIN or VIN3. Try to find out which
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2178  		 * one.
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2179  		 */
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2180  		reg = w83627ehf_read_value(data, W83627EHF_REG_TEMP_CONFIG[2]);
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2181  		if (data->temp_src[2] == 2 && (reg & 0x01))
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2182  			data->have_temp &= ~(1 << 2);
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2183  
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2184  		if ((data->temp_src[2] == 2 && (data->have_temp & (1 << 2)))
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2185  		    || (data->temp_src[3] == 2 && (data->have_temp & (1 << 3))))
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2186  			data->in6_skip = 1;
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2187  
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2188  		data->temp_label = w83667hg_b_temp_label;
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2189  		data->have_temp_offset = data->have_temp & 0x07;
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2190  		for (i = 0; i < 3; i++) {
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2191  			if (data->temp_src[i] > 2)
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2192  				data->have_temp_offset &= ~(1 << i);
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2193  		}
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2194  	} else if (sio_data->kind == w83627uhg) {
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2195  		u8 reg;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2196  
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2197  		w83627ehf_set_temp_reg_ehf(data, 3);
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2198  
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2199  		/*
> aacb6b0052692c drivers/hwmon/w83627ehf.c     Jean Delvare           2012-03-13  2200  		 * Temperature sources for temp2 and temp3 are selected with
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2201  		 * bank 0, registers 0x49 and 0x4a.
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2202  		 */
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2203  		data->temp_src[0] = 0;	/* SYSTIN */
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2204  		reg = w83627ehf_read_value(data, 0x49) & 0x07;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2205  		/* Adjust to have the same mapping as other source registers */
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2206  		if (reg == 0)
> aacb6b0052692c drivers/hwmon/w83627ehf.c     Jean Delvare           2012-03-13  2207  			data->temp_src[1] = 1;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2208  		else if (reg >= 2 && reg <= 5)
> aacb6b0052692c drivers/hwmon/w83627ehf.c     Jean Delvare           2012-03-13  2209  			data->temp_src[1] = reg + 2;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2210  		else	/* should never happen */
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2211  			data->have_temp &= ~(1 << 1);
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2212  		reg = w83627ehf_read_value(data, 0x4a);
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2213  		data->temp_src[2] = reg >> 5;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2214  
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2215  		/*
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2216  		 * Skip temp3 if source is invalid or the same as temp1
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2217  		 * or temp2.
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2218  		 */
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2219  		if (data->temp_src[2] == 2 || data->temp_src[2] == 3 ||
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2220  		    data->temp_src[2] == data->temp_src[0] ||
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2221  		    ((data->have_temp & (1 << 1)) &&
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2222  		     data->temp_src[2] == data->temp_src[1]))
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2223  			data->have_temp &= ~(1 << 2);
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2224  		else
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2225  			data->temp3_val_only = 1;	/* No limit regs */
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2226  
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2227  		data->in6_skip = 1;			/* No VIN3 */
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2228  
> d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2229  		data->temp_label = w83667hg_b_temp_label;
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2230  		data->have_temp_offset = data->have_temp & 0x03;
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2231  		for (i = 0; i < 3; i++) {
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2232  			if (data->temp_src[i] > 1)
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2233  				data->have_temp_offset &= ~(1 << i);
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2234  		}
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2235  	} else {
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2236  		w83627ehf_set_temp_reg_ehf(data, 3);
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2237  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2238  		/* Temperature sources are fixed */
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2239  
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2240  		if (sio_data->kind == w83667hg) {
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2241  			u8 reg;
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2242  
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2243  			/*
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2244  			 * Chip supports either AUXTIN or VIN3. Try to find
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2245  			 * out which one.
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2246  			 */
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2247  			reg = w83627ehf_read_value(data,
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2248  						W83627EHF_REG_TEMP_CONFIG[2]);
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2249  			if (reg & 0x01)
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2250  				data->have_temp &= ~(1 << 2);
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2251  			else
> 6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2252  				data->in6_skip = 1;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2253  		}
> 840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2254  		data->have_temp_offset = data->have_temp & 0x07;
> a157d06d4d7031 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2255  	}
> a157d06d4d7031 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2256  
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2257  	if (sio_data->kind == nct6775) {
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2258  		data->has_fan_div = true;
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2259  		data->fan_from_reg = fan_from_reg16;
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2260  		data->fan_from_reg_min = fan_from_reg8;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2261  		data->REG_PWM = NCT6775_REG_PWM;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2262  		data->REG_TARGET = NCT6775_REG_TARGET;
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2263  		data->REG_FAN = NCT6775_REG_FAN;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2264  		data->REG_FAN_MIN = W83627EHF_REG_FAN_MIN;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2265  		data->REG_FAN_START_OUTPUT = NCT6775_REG_FAN_START_OUTPUT;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2266  		data->REG_FAN_STOP_OUTPUT = NCT6775_REG_FAN_STOP_OUTPUT;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2267  		data->REG_FAN_STOP_TIME = NCT6775_REG_FAN_STOP_TIME;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2268  		data->REG_FAN_MAX_OUTPUT = NCT6775_REG_FAN_MAX_OUTPUT;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2269  		data->REG_FAN_STEP_OUTPUT = NCT6775_REG_FAN_STEP_OUTPUT;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2270  	} else if (sio_data->kind == nct6776) {
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2271  		data->has_fan_div = false;
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2272  		data->fan_from_reg = fan_from_reg13;
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2273  		data->fan_from_reg_min = fan_from_reg13;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2274  		data->REG_PWM = NCT6775_REG_PWM;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2275  		data->REG_TARGET = NCT6775_REG_TARGET;
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2276  		data->REG_FAN = NCT6775_REG_FAN;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2277  		data->REG_FAN_MIN = NCT6776_REG_FAN_MIN;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2278  		data->REG_FAN_START_OUTPUT = NCT6775_REG_FAN_START_OUTPUT;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2279  		data->REG_FAN_STOP_OUTPUT = NCT6775_REG_FAN_STOP_OUTPUT;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2280  		data->REG_FAN_STOP_TIME = NCT6775_REG_FAN_STOP_TIME;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2281  	} else if (sio_data->kind == w83667hg_b) {
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2282  		data->has_fan_div = true;
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2283  		data->fan_from_reg = fan_from_reg8;
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2284  		data->fan_from_reg_min = fan_from_reg8;
> 279af1a91a0410 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2285  		data->REG_PWM = W83627EHF_REG_PWM;
> 279af1a91a0410 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2286  		data->REG_TARGET = W83627EHF_REG_TARGET;
> 279af1a91a0410 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2287  		data->REG_FAN = W83627EHF_REG_FAN;
> 279af1a91a0410 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2288  		data->REG_FAN_MIN = W83627EHF_REG_FAN_MIN;
> da2e025590cf70 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2289  		data->REG_FAN_START_OUTPUT = W83627EHF_REG_FAN_START_OUTPUT;
> da2e025590cf70 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2290  		data->REG_FAN_STOP_OUTPUT = W83627EHF_REG_FAN_STOP_OUTPUT;
> 279af1a91a0410 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2291  		data->REG_FAN_STOP_TIME = W83627EHF_REG_FAN_STOP_TIME;
> c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2292  		data->REG_FAN_MAX_OUTPUT =
> c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2293  		  W83627EHF_REG_FAN_MAX_OUTPUT_W83667_B;
> c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2294  		data->REG_FAN_STEP_OUTPUT =
> c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2295  		  W83627EHF_REG_FAN_STEP_OUTPUT_W83667_B;
> c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2296  	} else {
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2297  		data->has_fan_div = true;
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2298  		data->fan_from_reg = fan_from_reg8;
> 26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2299  		data->fan_from_reg_min = fan_from_reg8;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2300  		data->REG_PWM = W83627EHF_REG_PWM;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2301  		data->REG_TARGET = W83627EHF_REG_TARGET;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2302  		data->REG_FAN = W83627EHF_REG_FAN;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2303  		data->REG_FAN_MIN = W83627EHF_REG_FAN_MIN;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2304  		data->REG_FAN_START_OUTPUT = W83627EHF_REG_FAN_START_OUTPUT;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2305  		data->REG_FAN_STOP_OUTPUT = W83627EHF_REG_FAN_STOP_OUTPUT;
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2306  		data->REG_FAN_STOP_TIME = W83627EHF_REG_FAN_STOP_TIME;
> c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2307  		data->REG_FAN_MAX_OUTPUT =
> c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2308  		  W83627EHF_REG_FAN_MAX_OUTPUT_COMMON;
> c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2309  		data->REG_FAN_STEP_OUTPUT =
> c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2310  		  W83627EHF_REG_FAN_STEP_OUTPUT_COMMON;
> c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2311  	}
> da2e025590cf70 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2312  
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2313  	/* Setup input voltage scaling factors */
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2314  	if (sio_data->kind == w83627uhg)
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2315  		data->scale_in = scale_in_w83627uhg;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2316  	else
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2317  		data->scale_in = scale_in_common;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2318  
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2319  	/* Initialize the chip */
> bf164c58e58328 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-10-13  2320  	w83627ehf_init_device(data, sio_data->kind);
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2321  
> fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2322  	data->vrm = vid_which_vrm();
> 0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2323  
> 0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2324  	err = superio_enter(sio_data->sioreg);
> 0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2325  	if (err)
> 0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2326  		goto exit_release;
> 0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2327  
> 58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2328  	/* Read VID value */
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2329  	if (sio_data->kind == w83667hg || sio_data->kind == w83667hg_b ||
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2330  	    sio_data->kind == nct6775 || sio_data->kind == nct6776) {
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2331  		/*
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2332  		 * W83667HG has different pins for VID input and output, so
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2333  		 * we can get the VID input values directly at logical device D
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2334  		 * 0xe3.
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2335  		 */
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2336  		superio_select(sio_data->sioreg, W83667HG_LD_VID);
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2337  		data->vid = superio_inb(sio_data->sioreg, 0xe3);
> 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2338  		data->have_vid = true;
> eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2339  	} else if (sio_data->kind != w83627uhg) {
> 58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2340  		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
> 58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2341  		if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2342  			/*
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2343  			 * Set VID input sensibility if needed. In theory the
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2344  			 * BIOS should have set it, but in practice it's not
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2345  			 * always the case. We only do it for the W83627EHF/EHG
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2346  			 * because the W83627DHG is more complex in this
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2347  			 * respect.
> 8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2348  			 */
> 58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2349  			if (sio_data->kind == w83627ehf) {
> 58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2350  				en_vrm10 = superio_inb(sio_data->sioreg,
> 58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2351  						       SIO_REG_EN_VRM10);
> 58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2352  				if ((en_vrm10 & 0x08) && data->vrm == 90) {
> b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2353  					dev_warn(dev,
> b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2354  						 "Setting VID input voltage to TTL\n");
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2355  					superio_outb(sio_data->sioreg,
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2356  						     SIO_REG_EN_VRM10,
> fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2357  						     en_vrm10 & ~0x08);
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2358  				} else if (!(en_vrm10 & 0x08)
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2359  					   && data->vrm == 100) {
> b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2360  					dev_warn(dev,
> b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2361  						 "Setting VID input voltage to VRM10\n");
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2362  					superio_outb(sio_data->sioreg,
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2363  						     SIO_REG_EN_VRM10,
> fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2364  						     en_vrm10 | 0x08);
> fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2365  				}
> 58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2366  			}
> 58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2367  
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2368  			data->vid = superio_inb(sio_data->sioreg,
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2369  						SIO_REG_VID_DATA);
> cbe311f2a40b84 drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2370  			if (sio_data->kind == w83627ehf) /* 6 VID pins only */
> cbe311f2a40b84 drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2371  				data->vid &= 0x3f;
> 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2372  			data->have_vid = true;
> 58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2373  		} else {
> b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2374  			dev_info(dev,
> b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2375  				 "VID pins in output mode, CPU VID not available\n");
> fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2376  		}
> 237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2377  	}
> fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2378  
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2379  	if (fan_debounce &&
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2380  	    (sio_data->kind == nct6775 || sio_data->kind == nct6776)) {
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2381  		u8 tmp;
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2382  
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2383  		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2384  		tmp = superio_inb(sio_data->sioreg, NCT6775_REG_FAN_DEBOUNCE);
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2385  		if (sio_data->kind == nct6776)
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2386  			superio_outb(sio_data->sioreg, NCT6775_REG_FAN_DEBOUNCE,
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2387  				     0x3e | tmp);
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2388  		else
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2389  			superio_outb(sio_data->sioreg, NCT6775_REG_FAN_DEBOUNCE,
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2390  				     0x1e | tmp);
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2391  		pr_info("Enabled fan debounce for chip %s\n", data->name);
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2392  	}
> d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2393  
> 03f5de2bb7125e drivers/hwmon/w83627ehf.c     Jean Delvare           2011-10-13  2394  	w83627ehf_check_fan_inputs(sio_data, data);
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2395  
> 0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2396  	superio_exit(sio_data->sioreg);
> 0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2397  
> ea7be66c44e56b drivers/hwmon/w83627ehf.c     Mark M. Hoffman        2007-08-05  2398  	/* Read fan clock dividers immediately */
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2399  	w83627ehf_update_fan_div_common(dev, data);
> ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2400  
> b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2401  	/* Read pwm data to save original values */
> b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2402  	w83627ehf_update_pwm_common(dev, data);
> b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2403  	for (i = 0; i < data->pwm_num; i++)
> b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2404  		data->pwm_enable_orig[i] = data->pwm_enable[i];
> b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2405  
> 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2406  	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2407  							 data->name,
> 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2408  							 data,
> 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2409  							 &w83627ehf_chip_info,
> 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2410  							 w83627ehf_groups);
> 08c79950a047db drivers/hwmon/w83627ehf.c     Rudolf Marek           2006-07-05  2411  
> 266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2412  	return PTR_ERR_OR_ZERO(hwmon_dev);
>                                                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This should be:
> 
> 	if (IS_ERR(hwmon_dev)) {
> 		err = PTR_ERR(hwmon_dev);
> 		goto exit_release;
> 	}
> 
> 	return 0;

That looks about right to me; why don't you just submit that as a patch ?

Dave

> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2413  
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2414  exit_release:
> 1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2415  	release_region(res->start, IOREGION_LENGTH);
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2416  exit:
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25 @2417  	return err;
> 08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2418  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
