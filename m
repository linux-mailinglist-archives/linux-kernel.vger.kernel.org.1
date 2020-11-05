Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6623B2A73F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgKEAsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:48:24 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:63138 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgKEAsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:48:23 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201105004821epoutp04712f9aa1f4fb7453e3dc300790bad27b~EdiyYKENn0614206142epoutp04G
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:48:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201105004821epoutp04712f9aa1f4fb7453e3dc300790bad27b~EdiyYKENn0614206142epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604537301;
        bh=LahrI5dYfAx63RAZlIKl+jw6SAqcYaMwTRH34L/ytWk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pE4YvPYDLGx2pZUhvAgKS16Hvr2ish0YeqNLNnxxRs0AdmHz5c9tkJTpaion3dyDg
         tIsFBjj4V5h48qPXLcPPvgrNDhF5LLSkhrVN4mtbDB721j2WOakUaC3BHdfglP+ev9
         vZYKOg+HaTm2r3AygVc1aDdluAwWVS/OvNMq0ib0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201105004820epcas1p319c10547a663f3e7934e4a5de7fe4cc1~Edix51XpR0873408734epcas1p3k;
        Thu,  5 Nov 2020 00:48:20 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CRPyV2tnQzMqYmB; Thu,  5 Nov
        2020 00:48:18 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.AF.10463.ECB43AF5; Thu,  5 Nov 2020 09:48:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201105004813epcas1p41d451978c1e342a9cb6ec05f0b3e8b64~EdirnSkj-0973709737epcas1p4C;
        Thu,  5 Nov 2020 00:48:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201105004813epsmtrp2dab7fd3d23ea73945c236e39c30abf1b~Edirmq_750566305663epsmtrp2W;
        Thu,  5 Nov 2020 00:48:13 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-e6-5fa34bced5bc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.54.13470.DCB43AF5; Thu,  5 Nov 2020 09:48:13 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201105004813epsmtip267a8a33a6b4ed52ee8217815d7be3541~EdirXttFo0318603186epsmtip2P;
        Thu,  5 Nov 2020 00:48:13 +0000 (GMT)
Subject: Re: [PATCH 2/2] extcon: fsa9480: Support TI TSU6111 variant
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <ee854b7c-43bd-f618-e988-e71888a2af0b@samsung.com>
Date:   Thu, 5 Nov 2020 10:02:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <ead95b16-d8c8-37b3-bc00-408068d2fbba@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmru4578XxBrt3S1pM+bOcyeLyrjls
        FrcbV7A5MHvcubaHzaNvyypGj8+b5AKYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        LAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM953rWAtuMBR0Xp9LksDYwt7FyMnh4SAicSMRTPZ
        QGwhgR2MEpO6E7sYuYDsT4wS1079ZYdIfGOU+PtcoYuRA6zh5WobiJq9jBKtzz8zQTjvGSVW
        3H3FCNIgLOAi0dA6kQXEZhPQktj/4gbYBhGBcIl9xw4wg9jMAgoSv+5tYgWx+QUUJa7+eMwI
        soBXwE7i7H49kDCLgIrEgzWnwMpFBcIkTm5rARvPKyAocXLmE7DxnAL2Ei1HjrBBjBSXuPVk
        PhOELS+x/e0cZpDbJATeskss/NPCAvGxi8SbJZegbGGJV8e3QENCSuLzu71sEHa1xMqTIENB
        mjsYJbbsv8AKkTCW2L90MhPIocwCmhLrd+lDhBUldv6eywixmE/i3dceVkhg8Up0tAlBlChL
        XH5wlwnClpRY3N7JNoFRaRaSd2YheWEWkhdmISxbwMiyilEstaA4Nz212LDABDmqNzGCU6CW
        xQ7GuW8/6B1iZOJgPMQowcGsJMJ7wW9RvBBvSmJlVWpRfnxRaU5q8SFGU2AAT2SWEk3OBybh
        vJJ4Q1MjY2NjCxNDM1NDQyVx3j/aHfFCAumJJanZqakFqUUwfUwcnFINTP0iDofFT/78nXJr
        UlxE54uUt457zKV3+fjIh2wPP5JuZnLm/K53M978EFCeUbtZ+5uAsNb9XalOfwxf8md/8fg7
        RfzT4sJFZ+/uvl1S9WSb9wkXizN9Jl4aVvFMv6SM4yrMHd4fW7FBM2z2KWXvT6cC5svssTIL
        vay3X2hy/7vlVutnsvXsrNGck5JszZq//Fdq3rXvOhr7lEqsX04SzT/pzfdfLGDC29NzOrkv
        aHp+qnVd/lLzZIA6i+7/S3NTT/58Vxqiqbrsxuwl/ySTLi1K9u/2PvdF8kBHmLrXw1mapUIb
        er+VTKraMvcTp3Gar+zJSTM2uop+1Dm3/+SVvvd2JgEvYw14Z3xxtdaZ9kSJpTgj0VCLuag4
        EQCB5eFeCgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSvO5Z78XxBjvadS2m/FnOZHF51xw2
        i9uNK9gcmD3uXNvD5tG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZ77tWsBZc4KhovT6XpYGx
        hb2LkYNDQsBE4uVqmy5GLg4hgd2MEj8+TQOKcwLFJSWmXTzKDFEjLHH4cDFIWEjgLaNE7xVD
        EFtYwEWioXUiC4jNJqAlsf/FDTYQW0QgXGL2gvfMIDazgILEr3ubWCHm/2OUeDpjFhNIgl9A
        UeLqj8eMIPN5Bewkzu7XAwmzCKhIPFhzCqxXVCBMYueSx2DlvAKCEidnPgHbxSlgL9Fy5Agb
        xHx1iT/zLkHtEpe49WQ+E4QtL7H97RzmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYb
        FhjmpZbrFSfmFpfmpesl5+duYgRHg5bmDsbtqz7oHWJk4mA8xCjBwawkwnvBb1G8EG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd4bhQvjhATSE0tSs1NTC1KLYLJMHJxSDUyqod2PRL7JlaVE5vKe
        Vn1zQY1Ly2mmd0Fxa6rI9rj/T5t5y+x9qwStVabKMWt3/n13i8HAZH9Z2r1Jj5nCf/vkJ2r9
        jp7EKPqJg4nrOfPjsj98d8U2b45Kmy3g9Eyn+vafptCqoPzZajk7fuc9vuFeGxBY2iC4J0VP
        +++uCVfnRE0Vvx2R1SZQ/+LHIcGJuXtLhKakd/KyrTsUcS6k6DwzzzQvQ9Ni8a83LRh/HoqX
        Mf9i/jHkcsOFWfNOH3kg+nJB2p9NN52ZBT5vqZilu5Sx3tLzU9vtN2pdEzebHBB9W7nFjE/+
        nNRGza831rxXf/c8b0fwv3m1S+u+lQqfuNW3Kr9a4+3B8yr6PRIbdZVYijMSDbWYi4oTASse
        i5b1AgAA
X-CMS-MailID: 20201105004813epcas1p41d451978c1e342a9cb6ec05f0b3e8b64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201101004413epcas1p3e630dbf1581ff36176123f9f8ef15be2
References: <20201101004357.1076876-1-linus.walleij@linaro.org>
        <CGME20201101004413epcas1p3e630dbf1581ff36176123f9f8ef15be2@epcas1p3.samsung.com>
        <20201101004357.1076876-2-linus.walleij@linaro.org>
        <ead95b16-d8c8-37b3-bc00-408068d2fbba@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 12:01 PM, Chanwoo Choi wrote:
> Hi Linus,
> 
> On 11/1/20 9:43 AM, Linus Walleij wrote:
>> The Texas Instruments TSU6111 is compatible to the
>> FSA880/FSA9480.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  drivers/extcon/extcon-fsa9480.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
>> index 8405512f5199..08bdedbcdb0d 100644
>> --- a/drivers/extcon/extcon-fsa9480.c
>> +++ b/drivers/extcon/extcon-fsa9480.c
>> @@ -364,6 +364,7 @@ MODULE_DEVICE_TABLE(i2c, fsa9480_id);
>>  static const struct of_device_id fsa9480_of_match[] = {
>>  	{ .compatible = "fcs,fsa9480", },
>>  	{ .compatible = "fcs,fsa880", },
>> +	{ .compatible = "ti,tsu6111", },
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(of, fsa9480_of_match);
>>
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> As I replied from patch1, I'm waiting the review from DT maintainer.
> And then, I'll merge it.
> 
> 

Applied them. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
