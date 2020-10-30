Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6DD2A021E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgJ3KHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:07:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:21461 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgJ3KHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:07:04 -0400
IronPort-SDR: vCs6nUcPpXGwgXKuS1vpTQ3k4dXS69SrcEspUeyQv99tJBi7uEw8Bu1dYlNON3ZeZ2kfR4UDFK
 xmEZ40PtdtIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="230221625"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="230221625"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 03:07:03 -0700
IronPort-SDR: B+dFTSx9H2RpfWItIplOW5X6Z6paV7eHCGfCwgj60zhUPW+qIcTWBl10ZRoPyjBgzTfCZlGJkp
 3qKEm+MIzz1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="525843590"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 30 Oct 2020 03:07:02 -0700
Received: from [10.255.142.248] (vramuthx-MOBL1.gar.corp.intel.com [10.255.142.248])
        by linux.intel.com (Postfix) with ESMTP id 7EB2B5808A3;
        Fri, 30 Oct 2020 03:06:58 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [RESENDPATCH v15 2/2] mtd: rawnand: Add NAND controller support
 on Intel LGM SoC
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        robh+dt@kernel.org, boris.brezillon@collabora.com,
        devicetree@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20201026073021.33327-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201026073021.33327-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201028112037.326c06e2@xps13>
 <ab2b0b7a-93b6-51e4-ec08-7af4f4f38745@linux.intel.com>
 <20201030092329.280466d9@xps13>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <42724eab-7840-27f2-31ad-b5bc10fd89fd@linux.intel.com>
Date:   Fri, 30 Oct 2020 18:06:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201030092329.280466d9@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 30/10/2020 4:23 pm, Miquel Raynal wrote:
> Hello,
> 
>>>> +static const struct nand_controller_ops ebu_nand_controller_ops = {
>>>> +	.attach_chip = ebu_nand_attach_chip,
>>>> +	.setup_interface = ebu_nand_set_timings,
>>>> +	.exec_op = ebu_nand_exec_op,
>>>> +};
>>>> +
>>>> +static void ebu_dma_cleanup(struct ebu_nand_controller *ebu_host)
>>>> +{
>>>> +	if (ebu_host->dma_rx)
>>>> +		dma_release_channel(ebu_host->dma_rx);
>>>> +
>>>> +	if (ebu_host->dma_tx)
>>>> +		dma_release_channel(ebu_host->dma_tx);
>>>> +}
>>>> +
>>>> +static int ebu_nand_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct device *dev = &pdev->dev;
>>>> +	struct ebu_nand_controller *ebu_host;
>>>> +	struct nand_chip *nand;
>>>> +	struct mtd_info *mtd;
>>>> +	struct resource *res;
>>>> +	char *resname;
>>>> +	int ret, i;
>>>> +	u32 reg;
>>>> +
>>>> +	ebu_host = devm_kzalloc(dev, sizeof(*ebu_host), GFP_KERNEL);
>>>> +	if (!ebu_host)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	ebu_host->dev = dev;
>>>> +	nand_controller_init(&ebu_host->controller);
>>>> +
>>>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ebunand");
>>>> +	ebu_host->ebu = devm_ioremap_resource(&pdev->dev, res);
>>>> +	if (IS_ERR(ebu_host->ebu))
>>>> +		return PTR_ERR(ebu_host->ebu);
>>>> +
>>>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hsnand");
>>>> +	ebu_host->hsnand = devm_ioremap_resource(&pdev->dev, res);
>>>> +	if (IS_ERR(ebu_host->hsnand))
>>>> +		return PTR_ERR(ebu_host->hsnand);
>>>> +
>>>> +	ret = device_property_read_u32(dev, "nand,cs", &reg);
>>>
>>> There is no nand,cs property. Use 'reg' instead.
>> Noted.
>>>    
>>>> +	if (ret) {
>>>> +		dev_err(dev, "failed to get chip select: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +	ebu_host->cs_num = reg;
>>>
>>> The following for loop is weird, above you can only store a single cs
>>> number, while below you seem to reserve serveral memory areas. Please
>>> clarify this code.
>> This IP supports 2 chip select for 2 different memory regions so we used the below for loop, as per reviewers comment updated.
>> 		 EBU_CS0_BASE     0xE1C0_0000 (Memory-Mapped)
>> 		 EBU_CS0_IO_BASE  0x1740_0000 (FPI I/O Mapped)
>>
>>                    EBU_CS1_BASE     0xE140_0000 (Memory-Mapped)
>>                    EBU_CS1_IO_BASE  0x17C0_0000 (FPI I/O Mapped)
> 
> Please make a difference between, "there are two CS, either can be
> picked but we can use only one in this driver" or "there are two CS,
> one or both can be used". You can start with supporting a single CS (no
> matter which one is picked by the user with the reg property) but in
> this case there is no such for loop because only 1 CS is used. Or you
> can decide that both CS can be populated and in this case you must
> handle this in ->select_chip().
Sure, I will hadle the same as per your suggestion, thanks a lot!

Regards
Vadivel
> 
>>
>>>    
>>>> +
>>>> +	for (i = 0; i < MAX_CS; i++) {
>>>> +		resname = devm_kasprintf(dev, GFP_KERNEL, "nand_cs%d", i);
>>>> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>>>> +						   resname);
>>>> +		ebu_host->cs[i].chipaddr = devm_ioremap_resource(dev, res);
>>>> +		ebu_host->cs[i].nand_pa = res->start;
>>>> +		if (IS_ERR(ebu_host->cs[i].chipaddr))
>>>> +			return PTR_ERR(ebu_host->cs[i].chipaddr);
>>>> +	}
>>>> +
>>>> +	ebu_host->clk = devm_clk_get(dev, NULL);
>>>> +	if (IS_ERR(ebu_host->clk))
>>>> +		return dev_err_probe(dev, PTR_ERR(ebu_host->clk),
>>>> +				     "failed to get clock\n");
>>>> +
>>>> +	ret = clk_prepare_enable(ebu_host->clk);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "failed to enable clock: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +	ebu_host->clk_rate = clk_get_rate(ebu_host->clk);
>>>> +
>>>> +	ebu_host->dma_tx = dma_request_chan(dev, "tx");
>>>> +	if (IS_ERR(ebu_host->dma_tx))
>>>> +		return dev_err_probe(dev, PTR_ERR(ebu_host->dma_tx),
>>>> +				     "failed to request DMA tx chan!.\n");
>>>> +
>>>> +	ebu_host->dma_rx = dma_request_chan(dev, "rx");
>>>> +	if (IS_ERR(ebu_host->dma_rx))
>>>> +		return dev_err_probe(dev, PTR_ERR(ebu_host->dma_rx),
>>>> +				     "failed to request DMA rx chan!.\n");
>>>> +
>>>> +	for (i = 0; i < MAX_CS; i++) {
>>>> +		resname = devm_kasprintf(dev, GFP_KERNEL, "addr_sel%d", i);
>>>> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>>>> +						   resname);
>>>> +		if (!res)
>>>> +			return -EINVAL;
>>>> +		ebu_host->cs[i].addr_sel = res->start;
>>>> +		writel(ebu_host->cs[i].addr_sel | EBU_ADDR_MASK(5) |
>>>> +		       EBU_ADDR_SEL_REGEN, ebu_host->ebu + EBU_ADDR_SEL(i));
>>>> +	}
>>>> +
>>>> +	nand_set_flash_node(&ebu_host->chip, dev->of_node);
>>>> +	if (!mtd->name) {
>>>> +		dev_err(ebu_host->dev, "NAND label property is mandatory\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	mtd = nand_to_mtd(&ebu_host->chip);
>>>> +	mtd->dev.parent = dev;
>>>> +	ebu_host->dev = dev;
>>>> +
>>>> +	platform_set_drvdata(pdev, ebu_host);
>>>> +	nand_set_controller_data(&ebu_host->chip, ebu_host);
>>>> +
>>>> +	nand = &ebu_host->chip;
>>>> +	nand->controller = &ebu_host->controller;
>>>> +	nand->controller->ops = &ebu_nand_controller_ops;
>>>> +
>>>> +	/* Scan to find existence of the device */
>>>> +	ret = nand_scan(&ebu_host->chip, 1);
>>>> +	if (ret)
>>>> +		goto err_cleanup_dma;
>>>> +
>>>> +	ret = mtd_device_register(mtd, NULL, 0);
>>>> +	if (ret)
>>>> +		goto err_clean_nand;
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err_clean_nand:
>>>> +	nand_cleanup(&ebu_host->chip);
>>>> +err_cleanup_dma:
>>>> +	ebu_dma_cleanup(ebu_host);
>>>> +	clk_disable_unprepare(ebu_host->clk);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int ebu_nand_remove(struct platform_device *pdev)
>>>> +{
>>>> +	struct ebu_nand_controller *ebu_host = platform_get_drvdata(pdev);
>>>> +	int ret;
>>>> +
>>>> +	ret = mtd_device_unregister(nand_to_mtd(&ebu_host->chip));
>>>> +	WARN_ON(ret);
>>>> +	nand_cleanup(&ebu_host->chip);
>>>> +	ebu_nand_disable(&ebu_host->chip);
>>>> +	ebu_dma_cleanup(ebu_host);
>>>> +	clk_disable_unprepare(ebu_host->clk);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct of_device_id ebu_nand_match[] = {
>>>> +	{ .compatible = "intel,nand-controller", },
>>>
>>> No version or soc in the compatible? (not mandatory).
>> Yes, you're right, it should be "intel,lgm-ebunand", but this same driver supports 2 dfferent SOC's , that's the reason kept as generic
>> "intel,nand-controller"
> 
> In this case I guess declaring two compatibles is the way to go.
> 
> 
> Thanks,
> Miquèl
> 
