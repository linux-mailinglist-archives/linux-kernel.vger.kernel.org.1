Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05472A9E58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgKFUCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:02:24 -0500
Received: from mailrelay2-2.pub.mailoutpod1-cph3.one.com ([46.30.212.1]:31362
        "EHLO mailrelay2-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727341AbgKFUCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:references:cc:to:from:subject:from;
        bh=pGS+hRIpgZjBebzJuXnWRieKofFe11yfaznBGKJtRhk=;
        b=GwwduhURhWi2rqn7PJ9NkknQ1j90kPiJ7LyZSBrgZKeEpZYHap0S2aBsKT72hnOMVbPjG9VcKsHiJ
         F+yQReD5OHqxYgT9F8D3/u1RoNTrqIZcC2W7TISuJxZeIbNrnv0l6ULiaG5P2TKgablASlEK2W7vMV
         eyMJ/bwl0jnMIJC6/qdMIr8QqVxbaxTCbCnlGV0thA8Q2MAW9eh30ZIMf5eIiJHfEgNMvY3XnGhGEF
         ZH0XECqdCcsO3iQzM/37mpLNeeeHSaz7ZPuu9gaGrSFIE3YhtJggq5XoOT5OFo+fPLTp4eZnYLOSnT
         kvoVTjrSl3iw1wPRSSz+2oxAvDurvXA==
X-HalOne-Cookie: b7aca7b6cdc0a30bc058387c825741d339e1fc31
X-HalOne-ID: f9d6d3b5-206a-11eb-84b8-d0431ea8a290
Received: from [192.168.19.13] (h-155-4-128-97.na.cust.bahnhof.se [155.4.128.97])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id f9d6d3b5-206a-11eb-84b8-d0431ea8a290;
        Fri, 06 Nov 2020 20:02:19 +0000 (UTC)
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
From:   Henrik Rydberg <rydberg@bitmath.org>
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
References: <20200930105442.3f642f6c@aktux>
 <20200930164446.GB219887@roeck-us.net>
 <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
 <20201002002251.28462e64@aktux>
 <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
 <20201006090226.4275c824@kemnade.info>
 <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
 <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
 <20201104142057.62493c12@aktux>
 <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
 <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
 <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
 <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
 <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
Message-ID: <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
Date:   Fri, 6 Nov 2020 21:02:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So as it stands, it does not work at all. I will continue to check 
> another machine, and see if I can get something working.

On the MacBookAir3,1 the situation is somewhat better.

The first three tree positions result in zero failures and 10 reads per 
second. The fourth yields zero failues and 11 reads per second, within 
the margin of similarity.

So, the patch appears to have no apparent effect on the 3,1 series.

Now onto fixing the 1,1 behavior.

Henrik

