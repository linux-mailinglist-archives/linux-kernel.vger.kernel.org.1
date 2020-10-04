Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE6282B97
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 17:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgJDPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 11:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDPxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 11:53:50 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4DC0613CE;
        Sun,  4 Oct 2020 08:53:49 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x14so6303574oic.9;
        Sun, 04 Oct 2020 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u+sku0HH2+3QvSaCEnKkbz5kM8iPpztBRVnCPnfSqlo=;
        b=lFtJV+3UGDTtzQ/XeCkGAq8vaM3kH+I/YUEMZ6miacZ7OBeVgpAFdQMk0RafvdMpzx
         24czv7+zxUQlUPTGQbRxUB4l0mIu6DkyXdiHIXqXf4xARTFtFiyFLnfy85HNMi8N4FIA
         P+qTqQW0tZ0mB2jSSkrxkOm31MIGY0Bv+PIRrissa4naYUI/FwW4aiCm/thfGV23FLzL
         2zhkk4CWEEW0q4BZ06++U39CWu1eejLpg1n0S5dHEdPNUVtbPkIMHyD0PcEQAGHyngap
         aTBN1ftvgOeSocYuW8B6HeGNaZgNmOru5AIKdDBPKictmeR1a69WsJn25MISqmIygVxU
         eebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u+sku0HH2+3QvSaCEnKkbz5kM8iPpztBRVnCPnfSqlo=;
        b=iSJgm7WftV49cIipIqePa9DTtS/vByEObRyl2tRsN93OZK9nVQMHiqgs3w1fwNdc8B
         wNsgXBOzp0+wP9eQS3PKwE1bVEGMMWqur2FtUCFFKWLEfjTf9ZJxDC/RTKu1ZUxbG2Kt
         TEx09iq4/xynXDqvBApLKmcRO2U8XW+sAhgVpJFpZKpfg0PUonASk64GqsbBJRXMKHAY
         oSPcYVjEhIPkvavi4ifcyqVFVCGy7UcHijKG6zBZTaPde+wrj3JNJ5JULmv7aA7ZkEQ7
         3zCp4viIVwytbNzdKqXbtt5tGVOPfIlmjpSdjfwEW68SiWwK3cmHMmvKkJGgsGWVLOzy
         xvPg==
X-Gm-Message-State: AOAM532YYbP6ObV9VHJVbBe3kxRL1f/lUlaC7SxxLpddCdqlTHTSHxqo
        COG6SwCNUKHrfqrmBfCvvuboNrRh4hg=
X-Google-Smtp-Source: ABdhPJy9W1ulGjeyarn35fX9crDtbdL9e4ZrnONPc+Q9PhG2HfyS2zYYOvMFlXsO+62LnY5rnXb8HQ==
X-Received: by 2002:aca:470e:: with SMTP id u14mr5337584oia.7.1601826829081;
        Sun, 04 Oct 2020 08:53:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c61sm2086686otb.38.2020.10.04.08.53.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Oct 2020 08:53:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 4 Oct 2020 08:53:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ugur Usug <Ugur.Usug@maximintegrated.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] hwmon (pmbus/max20730): add device monitoring via
 debugfs
Message-ID: <20201004155347.GA113423@roeck-us.net>
References: <MWHPR11MB1965C01083AD013C630646B2FD3B0@MWHPR11MB1965.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1965C01083AD013C630646B2FD3B0@MWHPR11MB1965.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:15:38PM +0000, Ugur Usug wrote:
> Add debugfs interface support for accessing device specific registers (MFR_VOUT_MIN, 
> MFR_DEVSET1 and MFR_DEVSET2) and others including OPERATION, ON_OFF_CONFIG, 
> SMB_ALERT_MASK, VOUT_MODE, VOUT_COMMAND and VOUT_MAX.
> 
> This patch changes following items in max20730_debugfs_read(): 
> - the EINVAL returns to "Invalid" or "Not supported" 
> - strcpy() and strnlen() calls to strlcpy() calls
> - VOUT_MODE, VOUT_COMMAND and VOUT_MAX raw outputs to unit volts
> - terminating '\0' characters to the simple_read_from_buffer() return
> 
> Signed-off-by: Ugur Usug <ugur.usug@maximintegrated.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/max20730.c | 363 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 362 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
> index a151a2b..3175c9b 100644
> --- a/drivers/hwmon/pmbus/max20730.c
> +++ b/drivers/hwmon/pmbus/max20730.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/bits.h>
> +#include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -26,16 +27,367 @@ enum chips {
>  	max20743
>  };
>  
> +enum {
> +	MAX20730_DEBUGFS_VOUT_MIN = 0,
> +	MAX20730_DEBUGFS_FREQUENCY,
> +	MAX20730_DEBUGFS_PG_DELAY,
> +	MAX20730_DEBUGFS_INTERNAL_GAIN,
> +	MAX20730_DEBUGFS_BOOT_VOLTAGE,
> +	MAX20730_DEBUGFS_OUT_V_RAMP_RATE,
> +	MAX20730_DEBUGFS_OC_PROTECT_MODE,
> +	MAX20730_DEBUGFS_SS_TIMING,
> +	MAX20730_DEBUGFS_IMAX,
> +	MAX20730_DEBUGFS_OPERATION,
> +	MAX20730_DEBUGFS_ON_OFF_CONFIG,
> +	MAX20730_DEBUGFS_SMBALERT_MASK,
> +	MAX20730_DEBUGFS_VOUT_MODE,
> +	MAX20730_DEBUGFS_VOUT_COMMAND,
> +	MAX20730_DEBUGFS_VOUT_MAX,
> +	MAX20730_DEBUGFS_NUM_ENTRIES
> +};
> +
>  struct max20730_data {
>  	enum chips id;
>  	struct pmbus_driver_info info;
>  	struct mutex lock;	/* Used to protect against parallel writes */
>  	u16 mfr_devset1;
> +	u16 mfr_devset2;
> +	u16 mfr_voutmin;
>  };
>  
>  #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
>  
> +#define VOLT_FROM_REG(val)	DIV_ROUND_CLOSEST((val), 1 << 9)
> +
> +#define PMBUS_SMB_ALERT_MASK	0x1B
> +
> +#define MAX20730_MFR_VOUT_MIN	0xd1
>  #define MAX20730_MFR_DEVSET1	0xd2
> +#define MAX20730_MFR_DEVSET2	0xd3
> +
> +#define MAX20730_MFR_VOUT_MIN_MASK		GENMASK(9, 0)
> +#define MAX20730_MFR_VOUT_MIN_BIT_POS		0
> +
> +#define MAX20730_MFR_DEVSET1_RGAIN_MASK		(BIT(13) | BIT(14))
> +#define MAX20730_MFR_DEVSET1_OTP_MASK		(BIT(11) | BIT(12))
> +#define MAX20730_MFR_DEVSET1_VBOOT_MASK		(BIT(8) | BIT(9))
> +#define MAX20730_MFR_DEVSET1_OCP_MASK		(BIT(5) | BIT(6))
> +#define MAX20730_MFR_DEVSET1_FSW_MASK		GENMASK(4, 2)
> +#define MAX20730_MFR_DEVSET1_TSTAT_MASK		(BIT(0) | BIT(1))
> +
> +#define MAX20730_MFR_DEVSET1_RGAIN_BIT_POS	13
> +#define MAX20730_MFR_DEVSET1_OTP_BIT_POS	11
> +#define MAX20730_MFR_DEVSET1_VBOOT_BIT_POS	8
> +#define MAX20730_MFR_DEVSET1_OCP_BIT_POS	5
> +#define MAX20730_MFR_DEVSET1_FSW_BIT_POS	2
> +#define MAX20730_MFR_DEVSET1_TSTAT_BIT_POS	0
> +
> +#define MAX20730_MFR_DEVSET2_IMAX_MASK		GENMASK(10, 8)
> +#define MAX20730_MFR_DEVSET2_VRATE		(BIT(6) | BIT(7))
> +#define MAX20730_MFR_DEVSET2_OCPM_MASK		BIT(5)
> +#define MAX20730_MFR_DEVSET2_SS_MASK		(BIT(0) | BIT(1))
> +
> +#define MAX20730_MFR_DEVSET2_IMAX_BIT_POS	8
> +#define MAX20730_MFR_DEVSET2_VRATE_BIT_POS	6
> +#define MAX20730_MFR_DEVSET2_OCPM_BIT_POS	5
> +#define MAX20730_MFR_DEVSET2_SS_BIT_POS		0
> +
> +#define DEBUG_FS_DATA_MAX			16
> +
> +struct max20730_debugfs_data {
> +	struct i2c_client *client;
> +	int debugfs_entries[MAX20730_DEBUGFS_NUM_ENTRIES];
> +};
> +
> +#define to_psu(x, y) container_of((x), \
> +			struct max20730_debugfs_data, debugfs_entries[(y)])
> +
> +#ifdef CONFIG_DEBUG_FS
> +static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	int ret, len;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct max20730_debugfs_data *psu = to_psu(idxp, idx);
> +	const struct pmbus_driver_info *info;
> +	const struct max20730_data *data;
> +	char tbuf[DEBUG_FS_DATA_MAX] = { 0 };
> +	u16 val;
> +
> +	info = pmbus_get_driver_info(psu->client);
> +	data = to_max20730_data(info);
> +
> +	switch (idx) {
> +	case MAX20730_DEBUGFS_VOUT_MIN:
> +		ret = VOLT_FROM_REG(data->mfr_voutmin * 10000);
> +		len = snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d.%d\n",
> +			       ret / 10000, ret % 10000);
> +		break;
> +	case MAX20730_DEBUGFS_FREQUENCY:
> +		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_FSW_MASK)
> +			>> MAX20730_MFR_DEVSET1_FSW_BIT_POS;
> +
> +		if (val == 0)
> +			ret = 400;
> +		else if (val == 1)
> +			ret = 500;
> +		else if (val == 2 || val == 3)
> +			ret = 600;
> +		else if (val == 4)
> +			ret = 700;
> +		else if (val == 5)
> +			ret = 800;
> +		else
> +			ret = 900;
> +		len = snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
> +		break;
> +	case MAX20730_DEBUGFS_PG_DELAY:
> +		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_TSTAT_MASK)
> +			>> MAX20730_MFR_DEVSET1_TSTAT_BIT_POS;
> +
> +		if (val == 0)
> +			len = strlcpy(tbuf, "2000\n", DEBUG_FS_DATA_MAX);
> +		else if (val == 1)
> +			len = strlcpy(tbuf, "125\n", DEBUG_FS_DATA_MAX);
> +		else if (val == 2)
> +			len = strlcpy(tbuf, "62.5\n", DEBUG_FS_DATA_MAX);
> +		else
> +			len = strlcpy(tbuf, "32\n", DEBUG_FS_DATA_MAX);
> +		break;
> +	case MAX20730_DEBUGFS_INTERNAL_GAIN:
> +		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_RGAIN_MASK)
> +			>> MAX20730_MFR_DEVSET1_RGAIN_BIT_POS;
> +
> +		if (data->id == max20734) {
> +			/* AN6209 */
> +			if (val == 0)
> +				len = strlcpy(tbuf, "0.8\n", DEBUG_FS_DATA_MAX);
> +			else if (val == 1)
> +				len = strlcpy(tbuf, "3.2\n", DEBUG_FS_DATA_MAX);
> +			else if (val == 2)
> +				len = strlcpy(tbuf, "1.6\n", DEBUG_FS_DATA_MAX);
> +			else
> +				len = strlcpy(tbuf, "6.4\n", DEBUG_FS_DATA_MAX);
> +		} else if (data->id == max20730 || data->id == max20710) {
> +			/* AN6042 or AN6140 */
> +			if (val == 0)
> +				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
> +			else if (val == 1)
> +				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
> +			else if (val == 2)
> +				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
> +			else
> +				len = strlcpy(tbuf, "7.2\n", DEBUG_FS_DATA_MAX);
> +		} else if (data->id == max20743) {
> +			/* AN6042 */
> +			if (val == 0)
> +				len = strlcpy(tbuf, "0.45\n", DEBUG_FS_DATA_MAX);
> +			else if (val == 1)
> +				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
> +			else if (val == 2)
> +				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
> +			else
> +				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
> +		} else {
> +			len = strlcpy(tbuf, "Not supported\n", DEBUG_FS_DATA_MAX);
> +		}
> +		break;
> +	case MAX20730_DEBUGFS_BOOT_VOLTAGE:
> +		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_VBOOT_MASK)
> +			>> MAX20730_MFR_DEVSET1_VBOOT_BIT_POS;
> +
> +		if (val == 0)
> +			len = strlcpy(tbuf, "0.6484\n", DEBUG_FS_DATA_MAX);
> +		else if (val == 1)
> +			len = strlcpy(tbuf, "0.8984\n", DEBUG_FS_DATA_MAX);
> +		else if (val == 2)
> +			len = strlcpy(tbuf, "1.0\n", DEBUG_FS_DATA_MAX);
> +		else
> +			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +		break;
> +	case MAX20730_DEBUGFS_OUT_V_RAMP_RATE:
> +		val = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_VRATE)
> +			>> MAX20730_MFR_DEVSET2_VRATE_BIT_POS;
> +
> +		if (val == 0)
> +			len = strlcpy(tbuf, "4\n", DEBUG_FS_DATA_MAX);
> +		else if (val == 1)
> +			len = strlcpy(tbuf, "2\n", DEBUG_FS_DATA_MAX);
> +		else if (val == 2)
> +			len = strlcpy(tbuf, "1\n", DEBUG_FS_DATA_MAX);
> +		else
> +			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +		break;
> +	case MAX20730_DEBUGFS_OC_PROTECT_MODE:
> +		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_OCPM_MASK)
> +			>> MAX20730_MFR_DEVSET2_OCPM_BIT_POS;
> +		len = snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
> +		break;
> +	case MAX20730_DEBUGFS_SS_TIMING:
> +		val = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_SS_MASK)
> +			>> MAX20730_MFR_DEVSET2_SS_BIT_POS;
> +
> +		if (val == 0)
> +			len = strlcpy(tbuf, "0.75\n", DEBUG_FS_DATA_MAX);
> +		else if (val == 1)
> +			len = strlcpy(tbuf, "1.5\n", DEBUG_FS_DATA_MAX);
> +		else if (val == 2)
> +			len = strlcpy(tbuf, "3\n", DEBUG_FS_DATA_MAX);
> +		else
> +			len = strlcpy(tbuf, "6\n", DEBUG_FS_DATA_MAX);
> +		break;
> +	case MAX20730_DEBUGFS_IMAX:
> +		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_IMAX_MASK)
> +			>> MAX20730_MFR_DEVSET2_IMAX_BIT_POS;
> +		len = snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
> +		break;
> +	case MAX20730_DEBUGFS_OPERATION:
> +		ret = i2c_smbus_read_byte_data(psu->client, PMBUS_OPERATION);
> +		if (ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
> +		break;
> +	case MAX20730_DEBUGFS_ON_OFF_CONFIG:
> +		ret = i2c_smbus_read_byte_data(psu->client, PMBUS_ON_OFF_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
> +		break;
> +	case MAX20730_DEBUGFS_SMBALERT_MASK:
> +		ret = i2c_smbus_read_word_data(psu->client,
> +					       PMBUS_SMB_ALERT_MASK);
> +		if (ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
> +		break;
> +	case MAX20730_DEBUGFS_VOUT_MODE:
> +		ret = i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_MODE);
> +		if (ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", ret);
> +		break;
> +	case MAX20730_DEBUGFS_VOUT_COMMAND:
> +		ret = i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_COMMAND);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = VOLT_FROM_REG(ret * 10000);
> +		len = snprintf(tbuf, DEBUG_FS_DATA_MAX,
> +			       "%d.%d\n", ret / 10000, ret % 10000);
> +		break;
> +	case MAX20730_DEBUGFS_VOUT_MAX:
> +		ret = i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_MAX);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = VOLT_FROM_REG(ret * 10000);
> +		len = snprintf(tbuf, DEBUG_FS_DATA_MAX,
> +			       "%d.%d\n", ret / 10000, ret % 10000);
> +		break;
> +	default:
> +		len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +	}
> +
> +	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
> +}
> +
> +static const struct file_operations max20730_fops = {
> +	.llseek = noop_llseek,
> +	.read = max20730_debugfs_read,
> +	.write = NULL,
> +	.open = simple_open,
> +};
> +
> +static int max20730_init_debugfs(struct i2c_client *client,
> +				 struct max20730_data *data)
> +{
> +	int ret, i;
> +	struct dentry *debugfs;
> +	struct dentry *max20730_dir;
> +	struct max20730_debugfs_data *psu;
> +
> +	ret = i2c_smbus_read_word_data(client, MAX20730_MFR_DEVSET2);
> +	if (ret < 0)
> +		return ret;
> +	data->mfr_devset2 = ret;
> +
> +	ret = i2c_smbus_read_word_data(client, MAX20730_MFR_VOUT_MIN);
> +	if (ret < 0)
> +		return ret;
> +	data->mfr_voutmin = ret;
> +
> +	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
> +	if (!psu)
> +		return -ENOMEM;
> +	psu->client = client;
> +
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return -ENOENT;
> +
> +	max20730_dir = debugfs_create_dir(client->name, debugfs);
> +	if (!max20730_dir)
> +		return -ENOENT;
> +
> +	for (i = 0; i < MAX20730_DEBUGFS_NUM_ENTRIES; ++i)
> +		psu->debugfs_entries[i] = i;
> +
> +	debugfs_create_file("vout_min", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MIN],
> +			    &max20730_fops);
> +	debugfs_create_file("frequency", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_FREQUENCY],
> +			    &max20730_fops);
> +	debugfs_create_file("power_good_delay", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_PG_DELAY],
> +			    &max20730_fops);
> +	debugfs_create_file("internal_gain", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_INTERNAL_GAIN],
> +			    &max20730_fops);
> +	debugfs_create_file("boot_voltage", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_BOOT_VOLTAGE],
> +			    &max20730_fops);
> +	debugfs_create_file("out_voltage_ramp_rate", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_OUT_V_RAMP_RATE],
> +			    &max20730_fops);
> +	debugfs_create_file("oc_protection_mode", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_OC_PROTECT_MODE],
> +			    &max20730_fops);
> +	debugfs_create_file("soft_start_timing", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_SS_TIMING],
> +			    &max20730_fops);
> +	debugfs_create_file("imax", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_IMAX],
> +			    &max20730_fops);
> +	debugfs_create_file("operation", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_OPERATION],
> +			    &max20730_fops);
> +	debugfs_create_file("on_off_config", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_ON_OFF_CONFIG],
> +			    &max20730_fops);
> +	debugfs_create_file("smbalert_mask", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_SMBALERT_MASK],
> +			    &max20730_fops);
> +	debugfs_create_file("vout_mode", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MODE],
> +			    &max20730_fops);
> +	debugfs_create_file("vout_command", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_COMMAND],
> +			    &max20730_fops);
> +	debugfs_create_file("vout_max", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MAX],
> +			    &max20730_fops);
> +
> +	return 0;
> +}
> +#else
> +static int max20730_init_debugfs(struct i2c_client *client,
> +				 struct max20730_data *data)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_DEBUG_FS */
>  
>  /*
>   * Convert discreet value to direct data format. Strictly speaking, all passed
> @@ -370,7 +722,16 @@ static int max20730_probe(struct i2c_client *client,
>  		return ret;
>  	data->mfr_devset1 = ret;
>  
> -	return pmbus_do_probe(client, id, &data->info);
> +	ret = pmbus_do_probe(client, id, &data->info);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = max20730_init_debugfs(client, data);
> +	if (ret)
> +		dev_warn(dev, "Failed to register debugfs: %d\n",
> +			 ret);
> +
> +	return 0;
>  }
>  
>  static const struct i2c_device_id max20730_id[] = {
