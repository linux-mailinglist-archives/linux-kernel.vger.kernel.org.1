Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5A26D7E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgIQJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:42:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37070 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQJmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:42:24 -0400
X-Greylist: delayed 7243 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 05:42:13 EDT
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08H9SOu0013564;
        Thu, 17 Sep 2020 09:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ytD57QMqiKWQNplY93jZrowdzK2DoZ/yQOxZ/tObXsw=;
 b=mEch5/Fkmoat39Q2SzC41EGYMtR5Ts/YIWFiS+OXLtnRNVDmYBvSfpviAGizuMZS50Dp
 qNSWuAXfJD+QynED0/fWFcJbTVrW9Xe91BwdFdA8GFMqQhc8XBiRe++lThkIejKGk0PN
 Cov5FYnzNi8Ko8QN4urttce/KcsE00JWYuJG/0v+X5jJ6/QbS1pI5hypQCm/v7cDDzQz
 KhpU5SJMiotogZFoNMt2DLTuT4jePXmgG/Tq9E4poKpzf0YyEPao/opl8qlcVYBWiQHj
 iRN6jbhtw+RlvpzW0OXtAMwUvOV1vDbMFgKbuU/SOYX5M0gj9eNyVLWqVpLPw1Jin2lY YQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33j91dssfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 09:41:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08H9U3mB022840;
        Thu, 17 Sep 2020 09:41:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33khpmsank-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 09:41:48 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08H9fkGA032510;
        Thu, 17 Sep 2020 09:41:47 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 09:41:43 +0000
Date:   Thu, 17 Sep 2020 12:41:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: drivers/hwmon/w83627ehf.c:2417 w83627ehf_probe() warn: 'res->start'
 not released on lines: 2412.
Message-ID: <20200917094137.GL4282@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qDymnuGqqhW10CwH"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDymnuGqqhW10CwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5925fa68fe8244651b3f78a88c4af99190a88f0d
commit: 266cd5835947d08b7c963b6d9d9f15d9e481bd0a hwmon: (w83627ehf) convert to with_info interface
config: i386-randconfig-m021-20200916 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/hwmon/w83627ehf.c:2417 w83627ehf_probe() warn: 'res->start' not released on lines: 2412.

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=266cd5835947d08b7c963b6d9d9f15d9e481bd0a
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 266cd5835947d08b7c963b6d9d9f15d9e481bd0a
vim +2417 drivers/hwmon/w83627ehf.c

6c931ae1c09a96 drivers/hwmon/w83627ehf.c     Bill Pemberton         2012-11-19  2015  static int w83627ehf_probe(struct platform_device *pdev)
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2016  {
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2017  	struct device *dev = &pdev->dev;
a8b3a3a53f9a81 drivers/hwmon/w83627ehf.c     Jingoo Han             2013-07-30  2018  	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2019  	struct w83627ehf_data *data;
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2020  	struct resource *res;
03f5de2bb7125e drivers/hwmon/w83627ehf.c     Jean Delvare           2011-10-13  2021  	u8 en_vrm10;
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2022  	int i, err = 0;
266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2023  	struct device *hwmon_dev;
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2024  
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2025  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2026  	if (!request_region(res->start, IOREGION_LENGTH, DRVNAME)) {
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2027  		err = -EBUSY;
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2028  		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2029  			(unsigned long)res->start,
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2030  			(unsigned long)res->start + IOREGION_LENGTH - 1);
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2031  		goto exit;
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2032  	}
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2033  
32260d94408c55 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-03-12  2034  	data = devm_kzalloc(&pdev->dev, sizeof(struct w83627ehf_data),
32260d94408c55 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-03-12  2035  			    GFP_KERNEL);
e7e1ca6ef4f331 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-04  2036  	if (!data) {
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2037  		err = -ENOMEM;
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2038  		goto exit_release;
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2039  	}
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2040  
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2041  	data->addr = res->start;
9a61bf6300533d drivers/hwmon/w83627ehf.c     Ingo Molnar            2006-01-18  2042  	mutex_init(&data->lock);
9a61bf6300533d drivers/hwmon/w83627ehf.c     Ingo Molnar            2006-01-18  2043  	mutex_init(&data->update_lock);
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2044  	data->name = w83627ehf_device_names[sio_data->kind];
266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2045  	data->kind = sio_data->kind;
3300fb4f886880 drivers/hwmon/w83627ehf.c     Jean Delvare           2012-11-05  2046  	data->bank = 0xff;		/* Force initial bank selection */
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2047  	platform_set_drvdata(pdev, data);
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2048  
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2049  	/* 627EHG and 627EHF have 10 voltage inputs; 627DHG and 667HG have 9 */
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2050  	data->in_num = (sio_data->kind == w83627ehf) ? 10 : 9;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2051  	/* 667HG, NCT6775F, and NCT6776F have 3 pwms, and 627UHG has only 2 */
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2052  	switch (sio_data->kind) {
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2053  	default:
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2054  		data->pwm_num = 4;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2055  		break;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2056  	case w83667hg:
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2057  	case w83667hg_b:
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2058  	case nct6775:
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2059  	case nct6776:
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2060  		data->pwm_num = 3;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2061  		break;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2062  	case w83627uhg:
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2063  		data->pwm_num = 2;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2064  		break;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2065  	}
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2066  
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2067  	/* Default to 3 temperature inputs, code below will adjust as needed */
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2068  	data->have_temp = 0x07;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2069  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2070  	/* Deal with temperature register setup first. */
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2071  	if (sio_data->kind == nct6775 || sio_data->kind == nct6776) {
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2072  		int mask = 0;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2073  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2074  		/*
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2075  		 * Display temperature sensor output only if it monitors
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2076  		 * a source other than one already reported. Always display
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2077  		 * first three temperature registers, though.
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2078  		 */
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2079  		for (i = 0; i < NUM_REG_TEMP; i++) {
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2080  			u8 src;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2081  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2082  			data->reg_temp[i] = NCT6775_REG_TEMP[i];
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2083  			data->reg_temp_over[i] = NCT6775_REG_TEMP_OVER[i];
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2084  			data->reg_temp_hyst[i] = NCT6775_REG_TEMP_HYST[i];
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2085  			data->reg_temp_config[i] = NCT6775_REG_TEMP_CONFIG[i];
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2086  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2087  			src = w83627ehf_read_value(data,
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2088  						   NCT6775_REG_TEMP_SOURCE[i]);
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2089  			src &= 0x1f;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2090  			if (src && !(mask & (1 << src))) {
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2091  				data->have_temp |= 1 << i;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2092  				mask |= 1 << src;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2093  			}
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2094  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2095  			data->temp_src[i] = src;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2096  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2097  			/*
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2098  			 * Now do some register swapping if index 0..2 don't
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2099  			 * point to SYSTIN(1), CPUIN(2), and AUXIN(3).
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2100  			 * Idea is to have the first three attributes
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2101  			 * report SYSTIN, CPUIN, and AUXIN if possible
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2102  			 * without overriding the basic system configuration.
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2103  			 */
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2104  			if (i > 0 && data->temp_src[0] != 1
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2105  			    && data->temp_src[i] == 1)
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2106  				w82627ehf_swap_tempreg(data, 0, i);
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2107  			if (i > 1 && data->temp_src[1] != 2
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2108  			    && data->temp_src[i] == 2)
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2109  				w82627ehf_swap_tempreg(data, 1, i);
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2110  			if (i > 2 && data->temp_src[2] != 3
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2111  			    && data->temp_src[i] == 3)
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2112  				w82627ehf_swap_tempreg(data, 2, i);
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2113  		}
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2114  		if (sio_data->kind == nct6776) {
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2115  			/*
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2116  			 * On NCT6776, AUXTIN and VIN3 pins are shared.
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2117  			 * Only way to detect it is to check if AUXTIN is used
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2118  			 * as a temperature source, and if that source is
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2119  			 * enabled.
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2120  			 *
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2121  			 * If that is the case, disable in6, which reports VIN3.
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2122  			 * Otherwise disable temp3.
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2123  			 */
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2124  			if (data->temp_src[2] == 3) {
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2125  				u8 reg;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2126  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2127  				if (data->reg_temp_config[2])
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2128  					reg = w83627ehf_read_value(data,
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2129  						data->reg_temp_config[2]);
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2130  				else
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2131  					reg = 0; /* Assume AUXTIN is used */
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2132  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2133  				if (reg & 0x01)
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2134  					data->have_temp &= ~(1 << 2);
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2135  				else
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2136  					data->in6_skip = 1;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2137  			}
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2138  			data->temp_label = nct6776_temp_label;
02309ad2b8cbcf drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-03-10  2139  		} else {
02309ad2b8cbcf drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-03-10  2140  			data->temp_label = nct6775_temp_label;
02309ad2b8cbcf drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-03-10  2141  		}
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2142  		data->have_temp_offset = data->have_temp & 0x07;
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2143  		for (i = 0; i < 3; i++) {
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2144  			if (data->temp_src[i] > 3)
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2145  				data->have_temp_offset &= ~(1 << i);
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2146  		}
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2147  	} else if (sio_data->kind == w83667hg_b) {
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2148  		u8 reg;
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2149  
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2150  		w83627ehf_set_temp_reg_ehf(data, 4);
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2151  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2152  		/*
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2153  		 * Temperature sources are selected with bank 0, registers 0x49
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2154  		 * and 0x4a.
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2155  		 */
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2156  		reg = w83627ehf_read_value(data, 0x4a);
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2157  		data->temp_src[0] = reg >> 5;
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2158  		reg = w83627ehf_read_value(data, 0x49);
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2159  		data->temp_src[1] = reg & 0x07;
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2160  		data->temp_src[2] = (reg >> 4) & 0x07;
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2161  
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2162  		/*
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2163  		 * W83667HG-B has another temperature register at 0x7e.
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2164  		 * The temperature source is selected with register 0x7d.
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2165  		 * Support it if the source differs from already reported
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2166  		 * sources.
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2167  		 */
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2168  		reg = w83627ehf_read_value(data, 0x7d);
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2169  		reg &= 0x07;
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2170  		if (reg != data->temp_src[0] && reg != data->temp_src[1]
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2171  		    && reg != data->temp_src[2]) {
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2172  			data->temp_src[3] = reg;
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2173  			data->have_temp |= 1 << 3;
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2174  		}
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2175  
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2176  		/*
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2177  		 * Chip supports either AUXTIN or VIN3. Try to find out which
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2178  		 * one.
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2179  		 */
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2180  		reg = w83627ehf_read_value(data, W83627EHF_REG_TEMP_CONFIG[2]);
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2181  		if (data->temp_src[2] == 2 && (reg & 0x01))
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2182  			data->have_temp &= ~(1 << 2);
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2183  
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2184  		if ((data->temp_src[2] == 2 && (data->have_temp & (1 << 2)))
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2185  		    || (data->temp_src[3] == 2 && (data->have_temp & (1 << 3))))
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2186  			data->in6_skip = 1;
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2187  
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2188  		data->temp_label = w83667hg_b_temp_label;
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2189  		data->have_temp_offset = data->have_temp & 0x07;
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2190  		for (i = 0; i < 3; i++) {
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2191  			if (data->temp_src[i] > 2)
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2192  				data->have_temp_offset &= ~(1 << i);
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2193  		}
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2194  	} else if (sio_data->kind == w83627uhg) {
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2195  		u8 reg;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2196  
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2197  		w83627ehf_set_temp_reg_ehf(data, 3);
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2198  
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2199  		/*
aacb6b0052692c drivers/hwmon/w83627ehf.c     Jean Delvare           2012-03-13  2200  		 * Temperature sources for temp2 and temp3 are selected with
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2201  		 * bank 0, registers 0x49 and 0x4a.
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2202  		 */
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2203  		data->temp_src[0] = 0;	/* SYSTIN */
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2204  		reg = w83627ehf_read_value(data, 0x49) & 0x07;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2205  		/* Adjust to have the same mapping as other source registers */
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2206  		if (reg == 0)
aacb6b0052692c drivers/hwmon/w83627ehf.c     Jean Delvare           2012-03-13  2207  			data->temp_src[1] = 1;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2208  		else if (reg >= 2 && reg <= 5)
aacb6b0052692c drivers/hwmon/w83627ehf.c     Jean Delvare           2012-03-13  2209  			data->temp_src[1] = reg + 2;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2210  		else	/* should never happen */
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2211  			data->have_temp &= ~(1 << 1);
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2212  		reg = w83627ehf_read_value(data, 0x4a);
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2213  		data->temp_src[2] = reg >> 5;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2214  
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2215  		/*
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2216  		 * Skip temp3 if source is invalid or the same as temp1
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2217  		 * or temp2.
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2218  		 */
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2219  		if (data->temp_src[2] == 2 || data->temp_src[2] == 3 ||
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2220  		    data->temp_src[2] == data->temp_src[0] ||
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2221  		    ((data->have_temp & (1 << 1)) &&
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2222  		     data->temp_src[2] == data->temp_src[1]))
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2223  			data->have_temp &= ~(1 << 2);
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2224  		else
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2225  			data->temp3_val_only = 1;	/* No limit regs */
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2226  
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2227  		data->in6_skip = 1;			/* No VIN3 */
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2228  
d36cf32c9a6c4f drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-07  2229  		data->temp_label = w83667hg_b_temp_label;
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2230  		data->have_temp_offset = data->have_temp & 0x03;
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2231  		for (i = 0; i < 3; i++) {
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2232  			if (data->temp_src[i] > 1)
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2233  				data->have_temp_offset &= ~(1 << i);
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2234  		}
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2235  	} else {
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2236  		w83627ehf_set_temp_reg_ehf(data, 3);
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2237  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2238  		/* Temperature sources are fixed */
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2239  
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2240  		if (sio_data->kind == w83667hg) {
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2241  			u8 reg;
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2242  
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2243  			/*
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2244  			 * Chip supports either AUXTIN or VIN3. Try to find
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2245  			 * out which one.
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2246  			 */
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2247  			reg = w83627ehf_read_value(data,
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2248  						W83627EHF_REG_TEMP_CONFIG[2]);
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2249  			if (reg & 0x01)
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2250  				data->have_temp &= ~(1 << 2);
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2251  			else
6ba71de5f81bbf drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2252  				data->in6_skip = 1;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2253  		}
840e191dba36f5 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-02-08  2254  		data->have_temp_offset = data->have_temp & 0x07;
a157d06d4d7031 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2255  	}
a157d06d4d7031 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2256  
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2257  	if (sio_data->kind == nct6775) {
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2258  		data->has_fan_div = true;
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2259  		data->fan_from_reg = fan_from_reg16;
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2260  		data->fan_from_reg_min = fan_from_reg8;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2261  		data->REG_PWM = NCT6775_REG_PWM;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2262  		data->REG_TARGET = NCT6775_REG_TARGET;
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2263  		data->REG_FAN = NCT6775_REG_FAN;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2264  		data->REG_FAN_MIN = W83627EHF_REG_FAN_MIN;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2265  		data->REG_FAN_START_OUTPUT = NCT6775_REG_FAN_START_OUTPUT;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2266  		data->REG_FAN_STOP_OUTPUT = NCT6775_REG_FAN_STOP_OUTPUT;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2267  		data->REG_FAN_STOP_TIME = NCT6775_REG_FAN_STOP_TIME;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2268  		data->REG_FAN_MAX_OUTPUT = NCT6775_REG_FAN_MAX_OUTPUT;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2269  		data->REG_FAN_STEP_OUTPUT = NCT6775_REG_FAN_STEP_OUTPUT;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2270  	} else if (sio_data->kind == nct6776) {
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2271  		data->has_fan_div = false;
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2272  		data->fan_from_reg = fan_from_reg13;
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2273  		data->fan_from_reg_min = fan_from_reg13;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2274  		data->REG_PWM = NCT6775_REG_PWM;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2275  		data->REG_TARGET = NCT6775_REG_TARGET;
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2276  		data->REG_FAN = NCT6775_REG_FAN;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2277  		data->REG_FAN_MIN = NCT6776_REG_FAN_MIN;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2278  		data->REG_FAN_START_OUTPUT = NCT6775_REG_FAN_START_OUTPUT;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2279  		data->REG_FAN_STOP_OUTPUT = NCT6775_REG_FAN_STOP_OUTPUT;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2280  		data->REG_FAN_STOP_TIME = NCT6775_REG_FAN_STOP_TIME;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2281  	} else if (sio_data->kind == w83667hg_b) {
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2282  		data->has_fan_div = true;
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2283  		data->fan_from_reg = fan_from_reg8;
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2284  		data->fan_from_reg_min = fan_from_reg8;
279af1a91a0410 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2285  		data->REG_PWM = W83627EHF_REG_PWM;
279af1a91a0410 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2286  		data->REG_TARGET = W83627EHF_REG_TARGET;
279af1a91a0410 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2287  		data->REG_FAN = W83627EHF_REG_FAN;
279af1a91a0410 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2288  		data->REG_FAN_MIN = W83627EHF_REG_FAN_MIN;
da2e025590cf70 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2289  		data->REG_FAN_START_OUTPUT = W83627EHF_REG_FAN_START_OUTPUT;
da2e025590cf70 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2290  		data->REG_FAN_STOP_OUTPUT = W83627EHF_REG_FAN_STOP_OUTPUT;
279af1a91a0410 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2291  		data->REG_FAN_STOP_TIME = W83627EHF_REG_FAN_STOP_TIME;
c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2292  		data->REG_FAN_MAX_OUTPUT =
c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2293  		  W83627EHF_REG_FAN_MAX_OUTPUT_W83667_B;
c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2294  		data->REG_FAN_STEP_OUTPUT =
c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2295  		  W83627EHF_REG_FAN_STEP_OUTPUT_W83667_B;
c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2296  	} else {
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2297  		data->has_fan_div = true;
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2298  		data->fan_from_reg = fan_from_reg8;
26bc440e3f14df drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-11  2299  		data->fan_from_reg_min = fan_from_reg8;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2300  		data->REG_PWM = W83627EHF_REG_PWM;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2301  		data->REG_TARGET = W83627EHF_REG_TARGET;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2302  		data->REG_FAN = W83627EHF_REG_FAN;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2303  		data->REG_FAN_MIN = W83627EHF_REG_FAN_MIN;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2304  		data->REG_FAN_START_OUTPUT = W83627EHF_REG_FAN_START_OUTPUT;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2305  		data->REG_FAN_STOP_OUTPUT = W83627EHF_REG_FAN_STOP_OUTPUT;
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2306  		data->REG_FAN_STOP_TIME = W83627EHF_REG_FAN_STOP_TIME;
c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2307  		data->REG_FAN_MAX_OUTPUT =
c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2308  		  W83627EHF_REG_FAN_MAX_OUTPUT_COMMON;
c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2309  		data->REG_FAN_STEP_OUTPUT =
c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2310  		  W83627EHF_REG_FAN_STEP_OUTPUT_COMMON;
c39aedafb24260 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2311  	}
da2e025590cf70 drivers/hwmon/w83627ehf.c     Guenter Roeck          2010-08-14  2312  
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2313  	/* Setup input voltage scaling factors */
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2314  	if (sio_data->kind == w83627uhg)
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2315  		data->scale_in = scale_in_w83627uhg;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2316  	else
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2317  		data->scale_in = scale_in_common;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2318  
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2319  	/* Initialize the chip */
bf164c58e58328 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-10-13  2320  	w83627ehf_init_device(data, sio_data->kind);
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2321  
fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2322  	data->vrm = vid_which_vrm();
0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2323  
0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2324  	err = superio_enter(sio_data->sioreg);
0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2325  	if (err)
0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2326  		goto exit_release;
0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2327  
58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2328  	/* Read VID value */
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2329  	if (sio_data->kind == w83667hg || sio_data->kind == w83667hg_b ||
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2330  	    sio_data->kind == nct6775 || sio_data->kind == nct6776) {
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2331  		/*
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2332  		 * W83667HG has different pins for VID input and output, so
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2333  		 * we can get the VID input values directly at logical device D
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2334  		 * 0xe3.
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2335  		 */
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2336  		superio_select(sio_data->sioreg, W83667HG_LD_VID);
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2337  		data->vid = superio_inb(sio_data->sioreg, 0xe3);
266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2338  		data->have_vid = true;
eff7687d473c31 drivers/hwmon/w83627ehf.c     Jean Delvare           2011-11-04  2339  	} else if (sio_data->kind != w83627uhg) {
58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2340  		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2341  		if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2342  			/*
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2343  			 * Set VID input sensibility if needed. In theory the
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2344  			 * BIOS should have set it, but in practice it's not
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2345  			 * always the case. We only do it for the W83627EHF/EHG
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2346  			 * because the W83627DHG is more complex in this
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2347  			 * respect.
8969e84d954af3 drivers/hwmon/w83627ehf.c     Guenter Roeck          2012-01-19  2348  			 */
58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2349  			if (sio_data->kind == w83627ehf) {
58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2350  				en_vrm10 = superio_inb(sio_data->sioreg,
58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2351  						       SIO_REG_EN_VRM10);
58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2352  				if ((en_vrm10 & 0x08) && data->vrm == 90) {
b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2353  					dev_warn(dev,
b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2354  						 "Setting VID input voltage to TTL\n");
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2355  					superio_outb(sio_data->sioreg,
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2356  						     SIO_REG_EN_VRM10,
fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2357  						     en_vrm10 & ~0x08);
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2358  				} else if (!(en_vrm10 & 0x08)
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2359  					   && data->vrm == 100) {
b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2360  					dev_warn(dev,
b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2361  						 "Setting VID input voltage to VRM10\n");
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2362  					superio_outb(sio_data->sioreg,
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2363  						     SIO_REG_EN_VRM10,
fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2364  						     en_vrm10 | 0x08);
fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2365  				}
58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2366  			}
58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2367  
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2368  			data->vid = superio_inb(sio_data->sioreg,
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2369  						SIO_REG_VID_DATA);
cbe311f2a40b84 drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2370  			if (sio_data->kind == w83627ehf) /* 6 VID pins only */
cbe311f2a40b84 drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2371  				data->vid &= 0x3f;
266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2372  			data->have_vid = true;
58e6e78119da2b drivers/hwmon/w83627ehf.c     Jean Delvare           2008-01-03  2373  		} else {
b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2374  			dev_info(dev,
b55f375725ff85 drivers/hwmon/w83627ehf.c     Guenter Roeck          2013-01-10  2375  				 "VID pins in output mode, CPU VID not available\n");
fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2376  		}
237c8d2f54ff12 drivers/hwmon/w83627ehf.c     Gong Jun               2009-03-30  2377  	}
fc18d6c0479d5b drivers/hwmon/w83627ehf.c     Jean Delvare           2007-06-24  2378  
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2379  	if (fan_debounce &&
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2380  	    (sio_data->kind == nct6775 || sio_data->kind == nct6776)) {
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2381  		u8 tmp;
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2382  
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2383  		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2384  		tmp = superio_inb(sio_data->sioreg, NCT6775_REG_FAN_DEBOUNCE);
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2385  		if (sio_data->kind == nct6776)
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2386  			superio_outb(sio_data->sioreg, NCT6775_REG_FAN_DEBOUNCE,
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2387  				     0x3e | tmp);
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2388  		else
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2389  			superio_outb(sio_data->sioreg, NCT6775_REG_FAN_DEBOUNCE,
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2390  				     0x1e | tmp);
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2391  		pr_info("Enabled fan debounce for chip %s\n", data->name);
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2392  	}
d42e869acf0da4 drivers/hwmon/w83627ehf.c     Ian Dobson             2011-03-07  2393  
03f5de2bb7125e drivers/hwmon/w83627ehf.c     Jean Delvare           2011-10-13  2394  	w83627ehf_check_fan_inputs(sio_data, data);
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2395  
0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2396  	superio_exit(sio_data->sioreg);
0d0235301b3a53 drivers/hwmon/w83627ehf.c     Katsumi Sato           2017-02-22  2397  
ea7be66c44e56b drivers/hwmon/w83627ehf.c     Mark M. Hoffman        2007-08-05  2398  	/* Read fan clock dividers immediately */
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2399  	w83627ehf_update_fan_div_common(dev, data);
ec3e5a16446fef drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-02  2400  
b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2401  	/* Read pwm data to save original values */
b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2402  	w83627ehf_update_pwm_common(dev, data);
b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2403  	for (i = 0; i < data->pwm_num; i++)
b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2404  		data->pwm_enable_orig[i] = data->pwm_enable[i];
b84bb5186297d1 drivers/hwmon/w83627ehf.c     Guenter Roeck          2011-02-13  2405  
266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2406  	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2407  							 data->name,
266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2408  							 data,
266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2409  							 &w83627ehf_chip_info,
266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2410  							 w83627ehf_groups);
08c79950a047db drivers/hwmon/w83627ehf.c     Rudolf Marek           2006-07-05  2411  
266cd5835947d0 drivers/hwmon/w83627ehf.c     Dr. David Alan Gilbert 2019-11-24  2412  	return PTR_ERR_OR_ZERO(hwmon_dev);
                                                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This should be:

	if (IS_ERR(hwmon_dev)) {
		err = PTR_ERR(hwmon_dev);
		goto exit_release;
	}

	return 0;

08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2413  
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2414  exit_release:
1ea6dd3840e5a2 drivers/hwmon/w83627ehf.c     David Hubbard          2007-06-24  2415  	release_region(res->start, IOREGION_LENGTH);
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2416  exit:
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25 @2417  	return err;
08e7e2789e0da4 drivers/i2c/chips/w83627ehf.c Jean Delvare           2005-04-25  2418  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--qDymnuGqqhW10CwH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
IKtMnFwE1jMVeXnxf6+OTxLgzgEA

--qDymnuGqqhW10CwH--
