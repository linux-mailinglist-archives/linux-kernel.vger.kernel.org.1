Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6F2D7A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394463AbgLKQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:13:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54122 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388137AbgLKQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:13:12 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201211161220euoutp029d5c8af130f05b6a69fcad17673b6b2d~PtXzu7Fuu2645826458euoutp02c
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:12:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201211161220euoutp029d5c8af130f05b6a69fcad17673b6b2d~PtXzu7Fuu2645826458euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607703140;
        bh=el27wjkB03BD2GBHtV2+CcgWrEOiFY8oP9WGEqT7f+c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MrWAs6Jvcw4f3mhN8ytSkVjd7E91SRt7LmNkEjAMIKfZirFJciytH7s7k7Gplp8nW
         KoxaU749TYOMHD+UKhegtxPZXaeOcYgkdqSe9kXaemOsa5U2GYyRcAJUQJRskpGGzM
         uE4XvNVwGkNovL0PXvniCDkYwzOK/l8RIrKhuITA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201211161218eucas1p2313d03c7ccad94c7bf1fb2fc813e34a7~PtXx8bskU1137111371eucas1p2-;
        Fri, 11 Dec 2020 16:12:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 11.91.44805.26A93DF5; Fri, 11
        Dec 2020 16:12:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201211161217eucas1p1e66553fbb8d113b417e29150951df683~PtXw6z9DM1458514585eucas1p14;
        Fri, 11 Dec 2020 16:12:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201211161217eusmtrp1bb5cfe942aa95cd08dff7dae10ade071~PtXw6OC5d0443404434eusmtrp1V;
        Fri, 11 Dec 2020 16:12:17 +0000 (GMT)
X-AuditID: cbfec7f4-b4fff7000000af05-10-5fd39a6212d2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5F.2F.21957.16A93DF5; Fri, 11
        Dec 2020 16:12:17 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201211161216eusmtip16990dfa3816480c3167d01504772a9ed~PtXwgeBFg2472024720eusmtip12;
        Fri, 11 Dec 2020 16:12:16 +0000 (GMT)
Subject: Re: [PATCH 3/3] driver core: platform: use bus_type functions
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@arm.linux.org.uk>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <48759bfa-bd21-f28f-043f-7b866d1b7e04@samsung.com>
Date:   Fri, 11 Dec 2020 17:12:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201119124611.2573057-3-u.kleine-koenig@pengutronix.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7pJsy7HGzx6zGnRvHg9m8WqqTtZ
        LC7vmsNmMffLVGaLzR9eslncnjiZ0YHNo6W5h81j06pONo/9c9ewe/T/NfD4vEkugDWKyyYl
        NSezLLVI3y6BK2NKWy9rwQKzik3bN7M3MH7R7mLk5JAQMJHYu3oPexcjF4eQwApGickbJ0M5
        XxglDj5/zALhfGaUOHypn62LkQOs5UVrBER8OaPExv5uNgjnI6PEsQ+/GEHmCgu4SUx4uZkN
        xBYRWMoosf9HGojNLJAqcWxdI1gNm4ChRNfbLrAaXgE7iaZZR5hAbBYBVYlze0+wgNiiAkkS
        67t+QNUISpyc+QQszgk0v+nyfSaImfISzVtnM0PY4hK3nsxnAjlIQuACh8Tfl3eYIR51kXi5
        by+ULSzx6vgWdghbRuL05B4WiIZmRomH59ayQzg9jBKXm2YwQlRZS9w59wvsf2YBTYn1u/Qh
        QeEocWuaC4TJJ3HjrSDEDXwSk7ZNZ4YI80p0tAlBzFCTmHV8HdzWgxcuMU9gVJqF5LNZSL6Z
        heSbWQhrFzCyrGIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMO6f/Hf+yg3H5q496hxiZ
        OBgPMUpwMCuJ8P6uvxwvxJuSWFmVWpQfX1Sak1p8iFGag0VJnDdpy5p4IYH0xJLU7NTUgtQi
        mCwTB6dUA5PMsdbwX8t7pmqLqOeu/r/gxmq7hFWfzr9qO69nJLJ1VZaX6JwDtw9uunhSY8LN
        kn6jCxGLFrks3f9+Y//HXx5CO979O53GZX9hpdHruQWPvs3WfOVk1s7IfGVXsydnzaoncy3E
        0m+sO1lncqZlJuuBRekPare93XL6dxmrhz/HvsorAQ0ND6tX7eLb33N0ucbnos364hUsv/c3
        FUxafSd/4bf8jFa+pCW3jlZNc1+1l+O/D0uwdaFG8Vmr0teP2QKXTkpmmOjSU7nx7Wb/xlt1
        fSISTnNF/opqOvJkGhqoCE/cJNAYHBe1kytj8yKXCG+xerkpR6SXvCj31GBXvbu+YRN7SZFd
        +9n0xjc6hUJKLMUZiYZazEXFiQCJ1+vaqgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xu7qJsy7HG+zvZ7VoXryezWLV1J0s
        Fpd3zWGzmPtlKrPF5g8v2SxuT5zM6MDm0dLcw+axaVUnm8f+uWvYPfr/Gnh83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzGlrZe1YIFZ
        xabtm9kbGL9odzFycEgImEi8aI3oYuTiEBJYyijR+vgQaxcjJ1BcRuLktAYoW1jiz7UuNhBb
        SOA9o8SWjTkgtrCAm8SEl5vZQJpFQJrvnPzGDJJgFkiV2Pz9MyPE1EZGiQ2/FjGBJNgEDCW6
        3kJM4hWwk2iadQQsziKgKnFu7wkWkItEBZIkzp4WhCgRlDg58wkLiM0JtKzp8n0miPlmEvM2
        P4TaJS/RvHU2lC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfm
        pesl5+duYgTG2bZjPzfvYJz36qPeIUYmDsZDjBIczEoivL/rL8cL8aYkVlalFuXHF5XmpBYf
        YjQFemcis5Rocj4w0vNK4g3NDEwNTcwsDUwtzYyVxHm3zl0TLySQnliSmp2aWpBaBNPHxMEp
        1cC0O5oloGG5dZdkwvSPku/a+j8ZTLh5d/K+H1tUmNZ919mwT0v9i0jSh5+q5x7WskgvdUya
        4bNh53lb5xItrb/a3z63bJp2QE+WT8Iz9IlBecEJx2MxKZZ9P8XMfrqu2KEzecf98P6al02d
        nHHpVsdVlgkZ2j7cXXT+9+OrrBliryqSGIo2PF+dzVXav6Ju/6uyhk2dGpJa4X+zhPKuxH+T
        W/P8ivu3pPpbAR/33BbweWK/7cnUf4er5QVYVzC+aWdcart4XchXnxSnSaKTSxh4c1rvaTOm
        LzZ4X36C3/+f+jez+VoS6T7bXPNS/5cefb7qpXct15/4B0LTX6zhk/Tk7V/KdDnp0ooFOX0G
        QtxKLMUZiYZazEXFiQCVdaUHPAMAAA==
X-CMS-MailID: 20201211161217eucas1p1e66553fbb8d113b417e29150951df683
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201211161217eucas1p1e66553fbb8d113b417e29150951df683
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201211161217eucas1p1e66553fbb8d113b417e29150951df683
References: <20201119124611.2573057-1-u.kleine-koenig@pengutronix.de>
        <20201119124611.2573057-3-u.kleine-koenig@pengutronix.de>
        <CGME20201211161217eucas1p1e66553fbb8d113b417e29150951df683@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 19.11.2020 13:46, Uwe Kleine-König wrote:
> This works towards the goal mentioned in 2006 in commit 594c8281f905
> ("[PATCH] Add bus_type probe, remove, shutdown methods.").
>
> The functions are moved to where the other bus_type functions are
> defined and renamed to match the already established naming scheme.
>
> Signed-off-by: Uwe Kleine-KÃ¶nig <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/base/platform.c | 132 ++++++++++++++++++++--------------------
>   1 file changed, 65 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index b847f5f8f992..8ad06daa2eaa 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -743,70 +743,6 @@ struct platform_device *platform_device_register_full(
>   }
>   EXPORT_SYMBOL_GPL(platform_device_register_full);
>   
> -static int platform_probe_fail(struct platform_device *pdev);
> -
> -static int platform_drv_probe(struct device *_dev)
> -{
> -	struct platform_driver *drv = to_platform_driver(_dev->driver);
> -	struct platform_device *dev = to_platform_device(_dev);
> -	int ret;
> -
> -	/*
> -	 * A driver registered using platform_driver_probe() cannot be bound
> -	 * again later because the probe function usually lives in __init code
> -	 * and so is gone. For these drivers .probe is set to
> -	 * platform_probe_fail in __platform_driver_probe(). Don't even
> -	 * prepare clocks and PM domains for these to match the traditional
> -	 * behaviour.
> -	 */
> -	if (unlikely(drv->probe == platform_probe_fail))
> -		return -ENXIO;
> -
> -	ret = of_clk_set_defaults(_dev->of_node, false);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = dev_pm_domain_attach(_dev, true);
> -	if (ret)
> -		goto out;
> -
> -	if (drv->probe) {
> -		ret = drv->probe(dev);
> -		if (ret)
> -			dev_pm_domain_detach(_dev, true);
> -	}
> -
> -out:
> -	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
> -		dev_warn(_dev, "probe deferral not supported\n");
> -		ret = -ENXIO;
> -	}
> -
> -	return ret;
> -}
> -
> -static int platform_drv_remove(struct device *_dev)
> -{
> -	struct platform_driver *drv = to_platform_driver(_dev->driver);
> -	struct platform_device *dev = to_platform_device(_dev);
> -	int ret = 0;
> -
> -	if (drv->remove)
> -		ret = drv->remove(dev);
> -	dev_pm_domain_detach(_dev, true);
> -
> -	return ret;
> -}
> -
> -static void platform_drv_shutdown(struct device *_dev)
> -{
> -	struct platform_driver *drv = to_platform_driver(_dev->driver);
> -	struct platform_device *dev = to_platform_device(_dev);
> -
> -	if (drv->shutdown)
> -		drv->shutdown(dev);
> -}
> -
>   /**
>    * __platform_driver_register - register a driver for platform-level devices
>    * @drv: platform driver structure
> @@ -817,9 +753,6 @@ int __platform_driver_register(struct platform_driver *drv,
>   {
>   	drv->driver.owner = owner;
>   	drv->driver.bus = &platform_bus_type;
> -	drv->driver.probe = platform_drv_probe;
> -	drv->driver.remove = platform_drv_remove;
> -	drv->driver.shutdown = platform_drv_shutdown;
>   
>   	return driver_register(&drv->driver);
>   }
> @@ -1349,6 +1282,68 @@ static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
>   	return 0;
>   }
>   
> +static int platform_probe(struct device *_dev)
> +{
> +	struct platform_driver *drv = to_platform_driver(_dev->driver);
> +	struct platform_device *dev = to_platform_device(_dev);
> +	int ret;
> +
> +	/*
> +	 * A driver registered using platform_driver_probe() cannot be bound
> +	 * again later because the probe function usually lives in __init code
> +	 * and so is gone. For these drivers .probe is set to
> +	 * platform_probe_fail in __platform_driver_probe(). Don't even prepare
> +	 * clocks and PM domains for these to match the traditional behaviour.
> +	 */
> +	if (unlikely(drv->probe == platform_probe_fail))
> +		return -ENXIO;
> +
> +	ret = of_clk_set_defaults(_dev->of_node, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = dev_pm_domain_attach(_dev, true);
> +	if (ret)
> +		goto out;
> +
> +	if (drv->probe) {
> +		ret = drv->probe(dev);
> +		if (ret)
> +			dev_pm_domain_detach(_dev, true);
> +	}
> +
> +out:
> +	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
> +		dev_warn(_dev, "probe deferral not supported\n");
> +		ret = -ENXIO;
> +	}
> +
> +	return ret;
> +}
> +
> +static int platform_remove(struct device *_dev)
> +{
> +	struct platform_driver *drv = to_platform_driver(_dev->driver);
> +	struct platform_device *dev = to_platform_device(_dev);
> +	int ret = 0;
> +
> +	if (drv->remove)
> +		ret = drv->remove(dev);
> +	dev_pm_domain_detach(_dev, true);
> +
> +	return ret;
> +}
> +
> +static void platform_shutdown(struct device *_dev)
> +{
> +	struct platform_driver *drv = to_platform_driver(_dev->driver);
> +	struct platform_device *dev = to_platform_device(_dev);
> +
> +	if (drv->shutdown)
> +		drv->shutdown(dev);
> +}

This will be called on unbound devices, what causes crash (observed on 
today's linux-next):

Will now restart.
8<--- cut here ---
Unable to handle kernel paging request at virtual address fffffff4
pgd = 289f4b67
[fffffff4] *pgd=6ffff841, *pte=00000000, *ppte=00000000
Internal error: Oops: 27 [#1] SMP ARM
Modules linked in: usb_f_ecm g_ether usb_f_rndis u_ether libcomposite 
brcmfmac sha256_generic libsha256 sha256_arm cfg80211 brcmutil 
panel_samsung_s6e8aa0 s5p_csi
CPU: 0 PID: 1715 Comm: reboot Not tainted 
5.10.0-rc7-next-20201211-00069-g1e8aa883315f #9935
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at platform_shutdown+0x8/0x18
LR is at device_shutdown+0x18c/0x25c
...
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4348404a  DAC: 00000051
Process reboot (pid: 1715, stack limit = 0xd050391e)
Stack: (0xc3405e60 to 0xc3406000)
[<c0a38bfc>] (platform_shutdown) from [<c0a34f78>] 
(device_shutdown+0x18c/0x25c)
[<c0a34f78>] (device_shutdown) from [<c036d3cc>] (kernel_restart+0xc/0x68)
[<c036d3cc>] (kernel_restart) from [<c036d680>] 
(__do_sys_reboot+0x154/0x1f0)
[<c036d680>] (__do_sys_reboot) from [<c03000c0>] (ret_fast_syscall+0x0/0x58)
Exception stack(0xc3405fa8 to 0xc3405ff0)
...
---[ end trace f39e94d5d6fd45bf ]---


> +
> +
>   int platform_dma_configure(struct device *dev)
>   {
>   	enum dev_dma_attr attr;
> @@ -1375,6 +1370,9 @@ struct bus_type platform_bus_type = {
>   	.dev_groups	= platform_dev_groups,
>   	.match		= platform_match,
>   	.uevent		= platform_uevent,
> +	.probe		= platform_probe,
> +	.remove		= platform_remove,
> +	.shutdown	= platform_shutdown,
>   	.dma_configure	= platform_dma_configure,
>   	.pm		= &platform_dev_pm_ops,
>   };

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

