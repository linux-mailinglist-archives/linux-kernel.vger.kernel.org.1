Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A1628DC78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgJNJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:12:16 -0400
Received: from mail-eopbgr70135.outbound.protection.outlook.com ([40.107.7.135]:63136
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbgJNJMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDe7vJERUMHA/NLwxirYiXPT2FgvDYguXYfWSgCWyG9rkN6c7LZwE9fBBVNIhOxa2qTonVOOgcb1hXQ3l0ccr2MASAON8gdQ/1B9bRzFRW7nTUf+eQa7GTgxCCvUPAiwBJ5sWomf/wU35vnd3WUms8HAcofzL8FLiEu6uYS1j/hfL7xsmsvAQFP/ogOPNh0oEVcVJLhMXsIyqHoXI3v3ZR3i6mSQz1VQ6T0EYxfpsxV+ApkhO9+FDCFdr8K5mdNELlN6xmy4sop/6L9lGLZO7zW+icwSFCbDUspqdZIwdk+LQumjdiRaQLIlnhOADRM2+XfMGD9VQTLUW+VEJtZm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHDF0STklHl3Av1YdgbRfOCZMak6njEmcgEYZ/f0z4M=;
 b=m+W26WG5G3GQ4N+ncyaJ7JrPpIxoFyydcupSzQFrJJ/5pFuD78ojzd+JUMsF1l7mYIhnEwjGgBVgJv3g7GPYwX+tGFG1NeiTgwQbso3TDCCYzM/jF5rV8OrbVFhBscJX3rKxo6du+vgZ5rEFYGMIh/xE2hk2ZNdu6tND5ClIK/ECbh8GhqbbGCAXGfG+OmOymoQ7ts/HYcH1fZZmLAdyCnSK7eCQZr//U3otI/dvSOucYygm0XzU/k/KYaaigazfTcPiQGROW5N4R4Hwu0R3B0R592YvMTDBcaIb66p+7PvUYXTLqWQ5mBddBrEiKXswU2JNhTyeB8uZJriVlOGIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHDF0STklHl3Av1YdgbRfOCZMak6njEmcgEYZ/f0z4M=;
 b=G85+adeuM90uvnkyBfx0yw2D5zeMvPNaPzD8gTebN2xu1QWarbA9ylFjSvuaPjNq/+GBSPQJ2iphxQnCcRUilhblpjv1lLljm9oRBlW/SjtT8gpZslaFFO1OATOWAwObo5HHvIzYNu2LAGSUIRm5qyNcsQkE4kZ0p43kNumwFXY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4348.eurprd02.prod.outlook.com (2603:10a6:10:43::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Wed, 14 Oct
 2020 09:12:10 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::9178:a26c:c1e1:636b]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::9178:a26c:c1e1:636b%4]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 09:12:10 +0000
Subject: Re: using one gpio for multiple dht22 sensors
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <91c25030-d5d1-e3e7-2d26-ac631dddc756@rasmusvillemoes.dk>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <1c0d4c55-1d76-8256-ac45-6e0e150309d9@axentia.se>
Date:   Wed, 14 Oct 2020 11:12:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <91c25030-d5d1-e3e7-2d26-ac631dddc756@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.207]
X-ClientProxiedBy: HE1P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::14)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.207) by HE1P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 09:12:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5695693a-d4ce-40b3-b330-08d870213b0a
X-MS-TrafficTypeDiagnostic: DB7PR02MB4348:
X-Microsoft-Antispam-PRVS: <DB7PR02MB43481F33B2A3554B471D8CD1BC050@DB7PR02MB4348.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14l9JdPVEhjKFbemIOCqVRhL/XiofdOgNQq/noL10X6qXxZTMpiVs8REABNO5JUmMID+uWQhakpyirojfvt+duh4APWGS7WleQks+7Kr/xJAN+pzN0e760BAU/RmTeOXISyzp0X1R8hlBzdfyfseFGH5Fwc21dLx6qdJaoeyuef/2e4PsGYQTJVLJQVPcwtXn4j7j28RpvVifZFDyXs5cCEFvKhmyz70HbveNBGCv90+qBN3y9D5HzsyqXIzHbzjNM6VBsqn0vvcqCDAxnC20lBcrdpNtMBNAWg9hhwQ0PAhsIoSSCWro8aWNTzXKriLB8jswlw3DBWmXZTDZeRlfCpu9fjkEzezC7UKqkqHd2TqMSjxR4rX6tsPG4RJU0SRgmRYJLhPhRaKKjpxsnAds3DKI4+9ONQ0okwwE82sx0iB4sfJZgH2uPY+083vKxvJ7Pm7FlzCq3c9huyKEcDe3r7O4v19WGEdNNexssixorIShDBdzJxFXJ1dS1lmr6ER
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(366004)(396003)(376002)(346002)(6916009)(83080400001)(966005)(956004)(5660300002)(478600001)(66946007)(8936002)(8676002)(86362001)(2616005)(4326008)(6486002)(4001150100001)(66476007)(52116002)(31696002)(36756003)(31686004)(53546011)(66556008)(316002)(16526019)(26005)(186003)(2906002)(83380400001)(16576012)(36916002)(43740500002)(15398625002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: neWItR1aSNEtv+9HiARkDrtMq6RjeVdEJfUf/5oXP7YhI25Qz/blZagRPgoU2ySytboXI7xHAZjN2UO92ocnE6V0MQiubeM3jXSytuBB2zk+u6flqHOdOr70FDpm9zUmO3OYkW9XxOprLDQpUwv7pQpRlu17QkfuesqxC+8AxO7jPRV2rK8/bt3XUNLcbqw9eZLXb/PitYVXY7jD6cfzH10xWrxiiyhEY7yAa3vywp2dQhPDLEyecuo8H4JEcoAwKEWsdiiL0J5nTnsmvUJh5TolU/VeE0OHI1kWjhLq4xTGvwl9Xm2kJcztyB5gpu73K4c457ZWnIzGS+FZYSB0khDTc49Tv3+0qEohxE5EqI+qn7CxlzCZ4WCHwaEufhr+/BenQBCnTc+cxiMzn1EnYMuUmy8ekiUeJwvEJGDNo/PZVm5Cf+j77pX0ksu71P25Phh7NdM3EDRjXBJh0JvmLfYGtWQWJpkG9tdn4PzgAmC1eOTJWtw/a7Ai7E9dXprYUCaG6jFOqahsWqKLkd+5hUFlgEJc0JfdtqXbxPj8cPFmRYf62ulLtPJeI05MWKm3pTK4uQiVIs5YXI48A5Dsh7jyD0ZVaVqPnMybIjH2DDB7a4kMXNTTY52Srgn2PlryE/626Sxeu/byxSYlW3/8rw==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 5695693a-d4ce-40b3-b330-08d870213b0a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 09:12:10.2322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6C5qhmtbg+vYNcu7SVAfSebxeRBOmXca3c88os2KAdJ/8x5LQeI63U8y/mLxkQl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4348
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasnus,

On 2020-10-13 23:34, Rasmus Villemoes wrote:
> Hi Peter
> 
> Since you're the author of io-channel-mux.txt, gpio-mux.txt and
> mux-controller.txt, I hope you don't mind me asking some perhaps silly
> questions.

Right, I ended up being the maintainer for a bunch of code I needed to
do things "the right way", i.e. without resorting to gpio-manipulation
and other breaches of abstractions from user-space...

> I'm going to hook up a bunch of dht22 humidity (and temperature) sensors
> [1] (drivers/iio/humidity/dht11.c), but partly due to limited number of
> available gpios, I'm also going to use a 74hc4051 multiplexer [2], so
> that all the dht22's actually sit on the same gpio.
> 
> It's pretty obvious how the multiplexer is to be described in
> device-tree (I'm probably going to send a patch to add support for an
> optional "enable-gpio", as on the 74hc4051, so that MUX_IDLE_DISCONNECT
> gets supported).
> 
> It also seems like io-channel-mux should somehow magically apply to all
> kinds of iio devices, but it can't be that simple. And if it is, I can't
> figure out how to write the DT. So:

The io-channel-mux is for the situation where you have only one iio-device,
and where you can control its environment with a mux. I.e. it is not about
how the device communicates with the host. You then get one new "virtual"
iio-device for every (valid) state of the mux, and when you access those
iio-devices, the mux is configured to select the correct input/output for
the iio-device in question. At least, it should be possible for output
devices as well, but I guess you kind of get into trouble with the output
signal not persisting when the mux changes state, but that is a problem
for the HW people ;-). I originally used it for a single adc device where
the mux simply selected what to measure.

> - do I need to teach the dht11.c driver to be mux-aware?
> - currently, a dht11/dht22 shows up in sysfs with just two files,
> in_humidityrelative_input and in_temp_input. Now, should I end up with
> one device and, say, 2*8 files (so that it seems like one sensor with
> eight input channels), or should it show up as eight different devices?
> If the latter, I guess the device tree would end up with the same "gpios
> = " spec for all eight - is that even allowed?

It's not 100% clear to me how this is connected, but I'm guessing that you
have the "DATA-signal" pin of the dht22s connected to the Y pins of the 4051,
and that Z pin of the 4051 is connected to some gpio, so that you are able
to communicate with the various dht22s by controlling the mux.

This calls for a mux on the single source of communication from the host
to the various real devices that share this single source of communication.
In other words, more like an i2c-mux than an io-channel-mux.

I.e., what you need is "the other kind" of mux/gpio driver, i.e. a driver
that "fans out" a single gpio so that other drivers can treat the pins on
the other side of the mux as gpios.

I guess you'd have to sort out irq-routing through this new mux-gpio driver
since the dht22 driver uses irqs to read input, and there are probably
various other interesting problems as well. Maybe the dgt22 driver needs
to be adjusted depending on how these problems are handled? E.g. maybe it
needs to disable IRQs when it is not expecting communication or something.

I'm not an expert on the intricacies of the gpio subsystem...

Does that help?

Cheers,
Peter

> If you can show how the DT is supposed to describe this situation, I'll
> try to fill out the missing pieces on the driver side.
> 
> [I could also just not describe the multiplexer at all and control
> everything about it by toggling gpios from userspace, and just have a
> single dht22 in DT, but I prefer doing this "the right way" if it's
> feasible.]
> 
> Thanks,
> Rasmus
> 
> Just FTR:
> 
> [1]
> https://www.electroschematics.com/wp-content/uploads/2015/02/DHT22-datasheet.pdf
> [2] https://assets.nexperia.com/documents/data-sheet/74HC_HCT4051.pdf
> 
