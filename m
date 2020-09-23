Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0343C275230
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIWHPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:15:49 -0400
Received: from mail-db8eur05on2098.outbound.protection.outlook.com ([40.107.20.98]:42017
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbgIWHPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:15:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5bxy027U93W91/AE+sFU9o3bnaJPjHGpe1fTtikSC4IlDyheJjDPd7yRAo16cPKGSjGvz8NqDiNIRcgVPGjLN9hZLfHLfgKkyR+5qawnPGpB8U6Avd4b0dZ8IzGOxXVVDEW9vIM0gGlBhOKvtGyAX4aEYnKjc2M6hPl48dQ8dP5zTg/wUYM1V6e2t2ubXXWYopjrR2T9KnvaYUuoQWEr0dx2PBLz+COnnV+3dYdPXlw/VUBV6tK2aXB8Izlzd50FNREMyeSLzjNB2489757no8uYBn5zpttKyN04qs5A00EGV9ooF5xpbInpLXxqoRmfgWXUhm8LLF54dwt2ErDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6K45rPfLgIJzPNlI5TytWUI7Q0niMhILy99zhww9uU=;
 b=FIOeZdgrdRyMT5Oj6RgGWzNae1SdQU5QmdJL+uqqBlWcFATwXAmq6N4m8HY9692XGJ9n8dnl80galuRVE53hImizViP+hdABg77e/sziQ9pg10Rm/PF2mVwByHcaLYADDFJbYiFg+QVI3IuyXM53KwOlleIlkgWI5nIb28J8RhyosSn9IbRaGoxzWGQbWWrIhvKxCoAcSWsAowlMZq2APBB2UIQaPRuBF+ii1pLNuMcqjRByRWJcb/fpxuAylnjwhprglwq1M713wiYlOxMhxjGBypmmnFodeu6zTEBGPgMz3xZYoXswqCdCdhOS9wgltZd9vUaBHl1B2nNKw/PiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6K45rPfLgIJzPNlI5TytWUI7Q0niMhILy99zhww9uU=;
 b=oxXNw3lenrzHzRNlexkoq/RN6/rMupHNbtmoMnZSZpCoDQ3in9Gpnj3uI5yWeS6nUlAY+iKpBt4cW9MDEn3cH5EevB4naNmbcmp0CC6o4QJW9GXEZb24NIvUdmzDM90ZED7Ro0CXgpNEBvLfKft7V2+mUPw7MCIIM1GYgfLabrI=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0122.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:ca::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Wed, 23 Sep 2020 07:15:42 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 07:15:42 +0000
Date:   Wed, 23 Sep 2020 10:15:36 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
Message-ID: <20200923071536.GA25173@plvision.eu>
References: <20200922235005.24371-1-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922235005.24371-1-vadym.kochan@plvision.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM6PR05CA0009.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::22) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM6PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:20b:2e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 07:15:42 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 471cd31b-02cd-4637-d2be-08d85f907b87
X-MS-TrafficTypeDiagnostic: HE1P190MB0122:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB012222365264E5395235110395380@HE1P190MB0122.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAqha3J7kVl4NPut82s6lw85wMltPmZG3BEU4I+F6UCzKRu2Hg8hHDhYrgUiHP1qK/lDdomW/TLTstIAuABicfWSU200lFqjvzha/q2oQ6tZ4ZXjN+lNDjKsv6tfQPp2wfa/3MF/XsUEB9SaXCHyTBIkPKpTtbRu9MUoM0qU8t8CnfURES/OPLVRYzKZ/63i69FSXVFVF7rA1gtShTA5pH0tiVDZBA5DjzThAWxBaLLp5//epWzz6fcTQVB0dvxgjBY9Ev+ab1kIyA74Arrfoc/FTIpVtZTmewhNC+j+NrWyibIcveG1ZJGfw1fYThDsph91HsYMuYJnw0SKsDLtWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39830400003)(396003)(366004)(52116002)(110136005)(7696005)(26005)(478600001)(6666004)(8676002)(86362001)(44832011)(55016002)(5660300002)(33656002)(956004)(36756003)(316002)(1076003)(8886007)(8936002)(186003)(2906002)(2616005)(66946007)(66476007)(16526019)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5P7dMh2eqcP88RFWQNg5GtwXN7fKPkwwnb+rW0JJMjSpfKyszNt2jehY29Yy/HWWY/xUhMv5ic8PSKYFk9uybnmk7lG46WnrCE1Ib2MOAw+acBlW4KAJ0EPFngr79BFlbdh+Fu/0n84pidYD1rLL8/zGU9Lb2maPo3SeTdSG2UHtYQuiT4Asa7wq81aE/M4e7bXoOmrioCZJh+RU1Y+C3b25gzJEsyyR9bP64cQymEygKKB9dP9euVSi6Saq5AX4STbj1/OM1zdpzervgqXkIC0UrB+AefvXW/tfMVYhfGJdlCF11TWv170IsDakd8OEI8TmjSeK5w8xvt3A/3JA4znVHG/Ye9KZ2Dsasdyfnr6lXWnC+CzBE6kWPbrtOjyUSBaUvN6VClai78bZbjQv3G3k4vnnAWjnBD1z95sHW2HXv8vOHCoPRs8HaisAAl6P7zPL//oqHOn0Y5vq3wJbCDcQ93xipdQ9F3yCklDKnc6eD4+aInqqjSuEhpUMPm74jTFjNfuS4p/qmwg3zsAmjrWFX8dZNYn/FN2qHkEDffdLg67fUz/ZBD+NbFOtMmXJhVpA7eSRE60xOtQTzfvN122dI25nvA1mOFsUD0w9jpC8dWhdEQh1jCBy43vyG2B9XvenKiSpM3nXuNzh3IqjQQ==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 471cd31b-02cd-4637-d2be-08d85f907b87
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 07:15:42.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqHzYa7583FZa+P1qLdz3JkCJcPhOoaqdr2NKZ2PpU370pMGiFbu48Jj20cXSZxkEu2ODBb4bPT0BN6/0tPeM7xDsupYnOSIBFoJHdkZFmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 02:50:05AM +0300, Vadym Kochan wrote:
[CUT]
>  
> +static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> +				   const struct nvmem_cell_info *info,
> +				   struct nvmem_cell *cell)
> +{
> +	int err;
> +
> +	err = __nvmem_cell_info_to_nvmem_cell(nvmem, info, cell);
> +	if (err)
> +		return err;
> +
> +	cell->name = kstrdup_const(info->name, GFP_KERNEL);
> +	if (!cell->name)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  /**
>   * nvmem_add_cells() - Add cell information to an nvmem device
>   *
> @@ -418,6 +434,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
>  
>  		rval = nvmem_cell_info_to_nvmem_cell(nvmem, &info[i], cells[i]);
>  		if (rval) {
> +			kfree_const(cells[i]->name);
Sorry, looks like this should not happen with new changes.

>  			kfree(cells[i]);
>  			goto err;
>  		}
> @@ -1460,7 +1477,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
>  	if (!nvmem)
>  		return -EINVAL;
>  
> -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> +	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
>  	if (rc)
>  		return rc;
>  
> @@ -1490,7 +1507,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
>  	if (!nvmem)
>  		return -EINVAL;
>  
> -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> +	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.17.1
> 
