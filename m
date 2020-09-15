Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BAB269B19
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgIOB25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:28:57 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:21654 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIOB22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:28:28 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200915012825epoutp01fe6e3adfc9f952a03db0c9d909193889~00MODlKtx1305413054epoutp01t
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:28:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200915012825epoutp01fe6e3adfc9f952a03db0c9d909193889~00MODlKtx1305413054epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600133305;
        bh=egT0OFD0weQH82AwocHfqlMU5Wad88C4WNlaSbzwML8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lL+c57sgrydLN/GcSitgj73kJq0gJKdZ7Ht32cjGSOxM3S6a/VK0U8NaeNHn2Qe6J
         LU/rq9t59sWQY2XaacIDoxIrzubfp7u1U0f28XgpnAvJuNFMp/g3ueQKnHraJ1v6Sy
         ljexY7PRG0bSH2xPlDS1L7Cf8kHJBJG0rsctGx54=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200915012825epcas1p33d8e767c5ef086dd2a6f4f99ff00c64c~00MNjwT8j2738627386epcas1p3R;
        Tue, 15 Sep 2020 01:28:25 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Br5GG40GnzMqYkX; Tue, 15 Sep
        2020 01:28:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.A4.19033.3B8106F5; Tue, 15 Sep 2020 10:28:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200915012818epcas1p2f9557f24f8fb9d48253fcfa034a4cd8c~00MHhaQOc0624206242epcas1p2I;
        Tue, 15 Sep 2020 01:28:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200915012818epsmtrp14e34024d346c1c1f55b2cb6daa022990~00MHgqsdg2243622436epsmtrp1V;
        Tue, 15 Sep 2020 01:28:18 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-82-5f6018b3d149
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.78.08382.2B8106F5; Tue, 15 Sep 2020 10:28:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200915012818epsmtip2928f047c277e54e4640ee610a8a0d9f0~00MHOlKma2594225942epsmtip2Q;
        Tue, 15 Sep 2020 01:28:18 +0000 (GMT)
Subject: Re: [PATCH 1/4] extcon: Add USB VBUS properties
To:     Angus Ainslie <angus@akkea.ca>, kernel@puri.sm
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <bfa20bf2-e13b-1cd4-52d9-c8fa922d5aac@samsung.com>
Date:   Tue, 15 Sep 2020 10:40:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200914164639.1487650-2-angus@akkea.ca>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0xbVRjNbcvrY13ZpZRxJcGVp4tCwo8Ha/cgQDbBpQTiqi7ETJP2jT6B
        0F/2tdNBIjS6whoVoZPMhg7jgAzYMgcVgbiUlP1qdLEOqKadAg6XScJYtzAH29S2b4v8d+53
        zved79x7cb6kD0vHGwwWxmygdQS2RTA2nZWXM4o06vzVla3UzfkwoPqWL/Ooj06dwyjH8ISA
        6rWfEFAzkz0Y9fXAUT4Vtp3G9uDKLxyngfJG8HtMedL/utLrPiNU/jEeAsrPPENAeX/keZXw
        YGNJPUNrGbOMMdQatQ2GulKi6k11uVquyCdzyCJqNyEz0HqmlKioVuXsa9BFlyJkh2mdNVpS
        0SxL5JWVmI1WCyOrN7KWUoIxaXWmIlMuS+tZq6Eut9aoLybz8wvkUaGmsX7Id01oWkj64Hy4
        G7SCn0QOkIgjuAu5v4kAB9iCS+A4QE9+HgExQgLvATTR1sQRDwBq7RjAnnXMtAf4HHEBoPFb
        YQF3WAXo345ZYUyVAil0vT8c7cBxKSxA83NMTMOHywANnL0e12AwG3lv/xqfug1mormHN+PW
        YliGHs8u8mJYAHei3sBUHKfCGuQf+/ipJhn5v1wSxOYnQgWyBzWxMh+modBSL4/DO9B3Kz3x
        RRH04CgwMiiM6RGsQH8uvs2FSUHLVzxCDqejvzrsT3EzGvRfxLjedoA83kACRxQib7+TF5vD
        h1no3GQeV85EE4/cgPNNQnfWPkngrMSo3S7hJC+gmYXfeBx+Dp1qO4Z9DgjXpjCuTQlcmxK4
        /jf7CgiGwHbGxOrrGJY0FWx+6xEQ/67ZinHQtXI31wd4OPABhPMJqXjKplZLxFr6SBNjNqrN
        Vh3D+oA8er2d/PTUWmP0vxssalJeUFhYSO0iFXKSJNLEiyGZWgLraAvTyDAmxvysj4cnprfy
        Ks/XWidvrDXPTeOV3wI8lSdAb7zznuhe49p657v9NWeNEV3NkbYLlZQt4RV5eEfRse5XpaPh
        lIwSNly99cTDYnxj4bXykO3FxfDFsduS5a5A5eWN8gxvzYT05ZaS0AM7SBZXN5giU6J+eFTa
        0VKmF1vVVxV3r6aRj5+ssyp04PCtDc3u/QdhVl/LpcjvP1oPfdpaYRO99M+BiD1x3v+h+H2f
        TePY99Y25/39Te5LeVXuOx5wMrikdbUUO51JFpET9Fwz7/VKu0YBG2zOyNwb6p5TDTc3rQ6u
        TicTg53Tx5Eu6e/t3UHN8BXxoaGqCseZX9Z3/lC9R0YmhB7NEgK2niaz+WaW/g/VXxGMNwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvO4miYR4gx8HVC0e37/NaLHk1TEm
        i+bF69ksulbvZLGY3zaDxeLyrjlsFouWtTJb3G5cwebA4TG1awWjx51re9g85p0M9Ng/dw27
        x6Mdtxg9+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK2PVobPsBQ/4KjbensbYwHieu4uRk0NC
        wETicscF5i5GLg4hgd2MEicPT2CFSEhKTLt4FCjBAWQLSxw+XAxR85ZRouvvOWaQGmEBC4lL
        S2+zgdSICBhJ3L+aClLDLPCGUWLbpVtMEA1bGSVmLfsN1sAmoCWx/8UNNhCbX0BR4uqPx4wg
        Nq+AncSfKw+ZQGwWAVWJ+RcOgNmiAmESO5c8ZoKoEZQ4OfMJC8gyTgEzibZrCSBhZgF1iT/z
        LjFD2OISt57MZ4Kw5SW2v53DPIFReBaS7llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRy
        veLE3OLSvHS95PzcTYzgSNPS3MG4fdUHvUOMTByMhxglOJiVRHgPNMbHC/GmJFZWpRblxxeV
        5qQWH2KU5mBREue9UbgwTkggPbEkNTs1tSC1CCbLxMEp1cCk7b9vj9DROVdCjrZsif2/7yeX
        8Kkkl5iZ94LZbYXCkyK2/wic+mbdosYQud6N4jbZ14PshdbyC3PfmHpmcfpKcdeZ91Imfq1Z
        5MT6R3f1ucjfFmssDQ02qQcpXLsou6rJztqkKObCLt+SDvWkxxP2Zvjf8apj2y0blLT5XvC+
        6gmPlaczGt//KWDiyBV9/9+XKku/i9fMt1Rcqer8zPIiT/T3E7eLJY37BCY/1j74Z2HnjuYL
        XswVcfMj55ckbpDQWHRv4zr5eRwnLu+uVYpSNpZQPMQqe9Hr/yUPyY6+nQt+9sy/xpVQ89mi
        Uv2m5Npb884e6eFxlny8eM3WLxXyN1fynd+8RZ5bmudMrPAUJZbijERDLeai4kQA8Pl61yMD
        AAA=
X-CMS-MailID: 20200915012818epcas1p2f9557f24f8fb9d48253fcfa034a4cd8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200914165800epcas1p12e04260289513eac00f442388d5ba374
References: <20200914164639.1487650-1-angus@akkea.ca>
        <CGME20200914165800epcas1p12e04260289513eac00f442388d5ba374@epcas1p1.samsung.com>
        <20200914164639.1487650-2-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/20 1:46 AM, Angus Ainslie wrote:
> USB type C, USB BC1.2 and USB power delivery allow different voltages
> and currents for VBUS so we need these additional properties.
> 
> Also USB type C allows separate device and power roles so add a VBUS SRC
> property.
> 
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> ---
>  include/linux/extcon.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index fd183fb9c20f..c4d48f4f74c4 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -117,14 +117,29 @@
>   * @type:       integer (intval)
>   * @value:      0 (USB/USB2) or 1 (USB3)
>   * @default:    0 (USB/USB2)
> + * - EXTCON_PROP_USB_VBUS_SRC

Could you explain more correct meaning of both sink and source?

> + * @type:	integer (intval)
> + * @value:	0 (sink) or 1 (source)
> + * @default:	0 (sink)
> + * - EXTCON_PROP_USB_VBUS_VOLTAGE
> + * @type:	integer (intval)
> + * @value:	negotiated vbus voltage in mV
> + * @default:	5000

Could you suggest the data why do you set default value as 5000?

> + * - EXTCON_PROP_USB_VBUS_CURRENT
> + * @type:	integer (intval)
> + * @value:	negotiated vbus current in mA
> + * @default:	100

ditto. Why default value is 100?

>   *
>   */
>  #define EXTCON_PROP_USB_VBUS		0
>  #define EXTCON_PROP_USB_TYPEC_POLARITY	1
>  #define EXTCON_PROP_USB_SS		2
> +#define EXTCON_PROP_USB_VBUS_SRC	3
> +#define EXTCON_PROP_USB_VBUS_VOLTAGE	4
> +#define EXTCON_PROP_USB_VBUS_CURRENT	5
>  
>  #define EXTCON_PROP_USB_MIN		0
> -#define EXTCON_PROP_USB_MAX		2
> +#define EXTCON_PROP_USB_MAX		5
>  #define EXTCON_PROP_USB_CNT	(EXTCON_PROP_USB_MAX - EXTCON_PROP_USB_MIN + 1)
>  
>  /* Properties of EXTCON_TYPE_CHG. */
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
