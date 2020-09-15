Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94E26A5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgIONKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgIONFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:05:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5918CC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:05:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so3280598wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PAedulOaLRGPWn1Q+RwcE7+ai8g8vapA/ETRTpmrMvA=;
        b=jOnakUbco4IRYyGk5bE3DYRjRvtFKeNnrPpQlHZm9vkVgtANfs6YSsuPafs8f8yxnW
         TWYg4nID670IQYnA5nwTvH7W0QZZ353jkg24qQafVf3HdVdCgyhH58O9dSy2aAQgV8gw
         u4iYPd9gY3vcqOQ6VESqLe0nk6F97Ds8SFPUaX7cJjku0BmYGfGOcvXIH8zy8qId7ucX
         FZc5KZsLCRSJpLbgr5zJ3eu1nL5/6amzUR5Rq7wOIwsRfFDZfPLBixmXDUjL0i0/RAGe
         Fd8pcxLFNcc+VQI8/h7VMZhbLSyz6qpY3hKNY27gBxmJExoDlmjUHWHijCduCInM1V8/
         j4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PAedulOaLRGPWn1Q+RwcE7+ai8g8vapA/ETRTpmrMvA=;
        b=HgRXOMvyQhl3/vjXQeuROPfcc22jZ8CQeHQlQZPAP2sElTK626lIN7Q/NCoQPxUPfO
         6JW0OyCwKKnlwLkPC89dip5MEMFarbDRwKnjq5zKJrU98Z6pIWiNxw9qcuKo6KuIGfNk
         Y8EoKKRb0NayYktmYJevlfLO5fNCl4+qn/O1H98rW+S358uAxrZrCqKIB65UU3hXD1xT
         NRVx+jfOwfFF1Z/wLOn9Q2oywGVSuKFXg+f4O2952aPv9VLBy9UMhbkPk0xHqc1rtA6w
         Q2b/Cem/B5aNH01wLpkd5GsM9aUSc4Xt9XLZh5O4buRosF81ZVLRqghxTSEWB/KPv5iG
         HJIg==
X-Gm-Message-State: AOAM531LHfXOOhlndZA717ZyV5N+nZ1LNIGDN6BjtDxSToUQSjovkQN4
        p/KRYbFEy8Oe2oE7NHyojiHE9Q==
X-Google-Smtp-Source: ABdhPJwSgGK8pvg6vZvi16/WZcjKVDit+Y5y4mAJO1zJtZiSdJ8WtZvErg/IdDO4zNNq3uaZq7Y/zw==
X-Received: by 2002:a5d:4842:: with SMTP id n2mr21740506wrs.260.1600175122708;
        Tue, 15 Sep 2020 06:05:22 -0700 (PDT)
Received: from [192.168.1.23] (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id v9sm26339953wru.37.2020.09.15.06.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:05:21 -0700 (PDT)
Subject: Re: [PATCH v9 00/11] Genericize DW MIPI DSI bridge and add i.MX 6
 driver
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philippe CORNU <philippe.cornu@st.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yannick FERTRE <yannick.fertre@st.com>,
        Andrzej Hajda <a.hajda@samsung.com>, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com
References: <20200609174959.955926-1-adrian.ratiu@collabora.com>
 <c6f10db1-7f56-a156-36a1-125e764c8c1a@baylibre.com>
 <87lfk3kaj4.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <b318069fe873e456f18d07d11f5d165667c9b04a.camel@collabora.com>
 <e0d0efec-09e0-6bf8-bab7-44accd14fa52@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwU0EVid/pAEQAND7AFhr
 5faf/EhDP9FSgYd/zgmb7JOpFPje3uw7jz9wFb28Cf0Y3CcncdElYoBNbRlesKvjQRL8mozV
 9RN+IUMHdUx1akR/A4BPXNdL7StfzKWOCxZHVS+rIQ/fE3Qz/jRmT6t2ZkpplLxVBpdu95qJ
 YwSZjuwFXdC+A7MHtQXYi3UfCgKiflj4+/ITcKC6EF32KrmIRqamQwiRsDcUUKlAUjkCLcHL
 CQvNsDdm2cxdHxC32AVm3Je8VCsH7/qEPMQ+cEZk47HOR3+Ihfn1LEG5LfwsyWE8/JxsU2a1
 q44LQM2lcK/0AKAL20XDd7ERH/FCBKkNVzi+svYJpyvCZCnWT0TRb72mT+XxLWNwfHTeGALE
 +1As4jIS72IglvbtONxc2OIid3tR5rX3k2V0iud0P7Hnz/JTdfvSpVj55ZurOl2XAXUpGbq5
 XRk5CESFuLQV8oqCxgWAEgFyEapI4GwJsvfl/2Er8kLoucYO1Id4mz6N33+omPhaoXfHyLSy
 dxD+CzNJqN2GdavGtobdvv/2V0wukqj86iKF8toLG2/Fia3DxMaGUxqI7GMOuiGZjXPt/et/
 qeOySghdQ7Sdpu6fWc8CJXV2mOV6DrSzc6ZVB4SmvdoruBHWWOR6YnMz01ShFE49pPucyU1h
 Av4jC62El3pdCrDOnWNFMYbbon3vABEBAAHCwn4EGAECAAkFAlYnf6QCGwICKQkQFpq3saTP
 +K7BXSAEGQECAAYFAlYnf6QACgkQd9zb2sjISdGToxAAkOjSfGxp0ulgHboUAtmxaU3viucV
 e2Hl1BVDtKSKmbIVZmEUvx9D06IijFaEzqtKD34LXD6fjl4HIyDZvwfeaZCbJbO10j3k7FJE
 QrBtpdVqkJxme/nYlGOVzcOiKIepNkwvnHVnuVDVPcXyj2wqtsU7VZDDX41z3X4xTQwY3SO1
 9nRO+f+i4RmtJcITgregMa2PcB0LvrjJlWroI+KAKCzoTHzSTpCXMJ1U/dEqyc87bFBdc+DI
 k8mWkPxsccdbs4t+hH0NoE3Kal9xtAl56RCtO/KgBLAQ5M8oToJVatxAjO1SnRYVN1EaAwrR
 xkHdd97qw6nbg9BMcAoa2NMc0/9MeiaQfbgW6b0reIz/haHhXZ6oYSCl15Knkr4t1o3I2Bqr
 Mw623gdiTzotgtId8VfLB2Vsatj35OqIn5lVbi2ua6I0gkI6S7xJhqeyrfhDNgzTHdQVHB9/
 7jnM0ERXNy1Ket6aDWZWCvM59dTyu37g3VvYzGis8XzrX1oLBU/tTXqo1IFqqIAmvh7lI0Se
 gCrXz7UanxCwUbQBFjzGn6pooEHJYRLuVGLdBuoApl/I4dLqCZij2AGa4CFzrn9W0cwm3HCO
 lR43gFyz0dSkMwNUd195FrvfAz7Bjmmi19DnORKnQmlvGe/9xEEfr5zjey1N9+mt3//geDP6
 clwKBkq0JggA+RTEAELzkgPYKJ3NutoStUAKZGiLOFMpHY6KpItbbHjF2ZKIU1whaRYkHpB2
 uLQXOzZ0d7x60PUdhqG3VmFnzXSztA4vsnDKk7x2xw0pMSTKhMafpxaPQJf494/jGnwBHyi3
 h3QGG1RjfhQ/OMTX/HKtAUB2ct3Q8/jBfF0hS5GzT6dYtj0Ci7+8LUsB2VoayhNXMnaBfh+Q
 pAhaFfRZWTjUFIV4MpDdFDame7PB50s73gF/pfQbjw5Wxtes/0FnqydfId95s+eej+17ldGp
 lMv1ok7K0H/WJSdr7UwDAHEYU++p4RRTJP6DHWXcByVlpNQ4SSAiivmWiwOt490+Ac7ATQRN
 WQbPAQgAvIoM384ZRFocFXPCOBir5m2J+96R2tI2XxMgMfyDXGJwFilBNs+fpttJlt2995A8
 0JwPj8SFdm6FBcxygmxBBCc7i/BVQuY8aC0Z/w9Vzt3Eo561r6pSHr5JGHe8hwBQUcNPd/9l
 2ynP57YTSE9XaGJK8gIuTXWo7pzIkTXfN40Wh5jeCCspj4jNsWiYhljjIbrEj300g8RUT2U0
 FcEoiV7AjJWWQ5pi8lZJX6nmB0lc69Jw03V6mblgeZ/1oTZmOepkagwy2zLDXxihf0GowUif
 GphBDeP8elWBNK+ajl5rmpAMNRoKxpN/xR4NzBg62AjyIvigdywa1RehSTfccQARAQABwsBf
 BBgBAgAJBQJNWQbPAhsMAAoJEBaat7Gkz/iuteIH+wZuRDqK0ysAh+czshtG6JJlLW6eXJJR
 Vi7dIPpgFic2LcbkSlvB8E25Pcfz/+tW+04Urg4PxxFiTFdFCZO+prfd4Mge7/OvUcwoSub7
 ZIPo8726ZF5/xXzajahoIu9/hZ4iywWPAHRvprXaim5E/vKjcTeBMJIqZtS4u/UK3EpAX59R
 XVxVpM8zJPbk535ELUr6I5HQXnihQm8l6rt9TNuf8p2WEDxc8bPAZHLjNyw9a/CdeB97m2Tr
 zR8QplXA5kogS4kLe/7/JmlDMO8Zgm9vKLHSUeesLOrjdZ59EcjldNNBszRZQgEhwaarfz46
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <e841d90b-0f1d-d5d9-9f67-f90d64c4fbc7@baylibre.com>
Date:   Tue, 15 Sep 2020 15:05:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e0d0efec-09e0-6bf8-bab7-44accd14fa52@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Gentle ping.

can you rebase on drm-misc-next so I can apply the IMX and STM patches ?

On 24/08/2020 11:47, Neil Armstrong wrote:
> Hi,
> 
> 
> On 15/08/2020 15:05, Ezequiel Garcia wrote:
>> Hi Neil,
>>
>> On Wed, 2020-07-01 at 09:35 +0300, Adrian Ratiu wrote:
>>> Hi Neil,
>>>
>>> On Mon, 29 Jun 2020, Neil Armstrong <narmstrong@baylibre.com> 
>>> wrote:
>>>> Hi Adrian, 
>>>>
>>>> On 09/06/2020 19:49, Adrian Ratiu wrote: 
> [...]
>>>
>>
>> It's been a month so I think it's a good idea to go forward
>> applying IMX and STM patches (probably with the usual
>> rebase dance).
>>
>> As for Rockchip...
>>
>>> The binding API removal change which directly touches RK can also 
>>> be applied separately, but unfortunately I do not have access to a 
>>> RK board with a DSI display to test it (or the bridge regmap logic 
>>> on RK btw...), I just "eye-balled" the RK code based on the public 
>>> docs and it LGTM.
>>>
>>
>> ... I'll be getting some DSI hardware to help with the pending
>> Rockchip issues, so we can tackle Rockchip as well. I'm quite sure
>> we'll loop Heiko as well if needed :-)
> 
> Sure, Adrian, can you rebase on drm-misc-next so I can apply the IMX and STM patches ?
> 
>>
>> Cheers,
>> Ezequiel
>>
>>>> Neil
>>>>
>>>>> Big thank you to everyone who has contributed to this up to now,
>>>>> Adrian
>>>>>
>>>>> Adrian Ratiu (11):
>>>>>   drm: bridge: dw_mipi_dsi: add initial regmap infrastructure
>>>>>   drm: bridge: dw_mipi_dsi: abstract register access using reg_fields
>>>>>   drm: bridge: dw_mipi_dsi: add dsi v1.01 support
>>>>>   drm: bridge: dw_mipi_dsi: remove bind/unbind API
>>>>>   dt-bindings: display: add i.MX6 MIPI DSI host controller doc
>>>>>   ARM: dts: imx6qdl: add missing mipi dsi properties
>>>>>   drm: imx: Add i.MX 6 MIPI DSI host platform driver
>>>>>   drm: stm: dw-mipi-dsi: let the bridge handle the HW version check
>>>>>   drm: bridge: dw-mipi-dsi: split low power cfg register into fields
>>>>>   drm: bridge: dw-mipi-dsi: fix bad register field offsets
>>>>>   Documentation: gpu: todo: Add dw-mipi-dsi consolidation plan
>>>>>
>>>>>  .../display/imx/fsl,mipi-dsi-imx6.yaml        | 112 +++
>>>>>  Documentation/gpu/todo.rst                    |  25 +
>>>>>  arch/arm/boot/dts/imx6qdl.dtsi                |   8 +
>>>>>  drivers/gpu/drm/bridge/synopsys/Kconfig       |   1 +
>>>>>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 713 ++++++++++++------
>>>>>  drivers/gpu/drm/imx/Kconfig                   |   8 +
>>>>>  drivers/gpu/drm/imx/Makefile                  |   1 +
>>>>>  drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c        | 399 ++++++++++
>>>>>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |   7 +-
>>>>>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         |  16 +-
>>>>>  10 files changed, 1059 insertions(+), 231 deletions(-)
>>>>>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
>>>>>  create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c
>>>>>
>>
> 

