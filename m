Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8FC28A887
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 19:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgJKRbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 13:31:35 -0400
Received: from www381.your-server.de ([78.46.137.84]:59638 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgJKRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 13:31:34 -0400
X-Greylist: delayed 1611 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Oct 2020 13:31:33 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ZHKg+MjGa0j1+rV6Y9+svUnYM6ktJkBSOZrPnXxDJSk=; b=YsJbRBAIcDXjKl1zhuQvq+oat3
        BVQSQaXQC0xlxM+2ElqCoWJlQiAi/iMpPFuTRcJcz6ZuM4cyJpvdGC9iGBLEz0HUDLVjjMyZOsdUF
        BMlYPXXDfnawZ+Tr4RPhjMsPzamWXTu2KkuhKdtz1k7l9ygOCHl3yab7x0vgH7YsoL9gg6ODO9E0a
        47o2M+jPzodCte05Y2QngXrAudTtyNrTz6+yvBxVYGdwj983+d4AhLtJ8+MX7fj/7II3Eo8WfXZWj
        PKeteagXGPGekjQMWpPIqkMjNZBPg0X/zgreSv82kxlc51O5oQ7ybzyhCChsbgwBwcCCGIj3/4h4J
        Zp705dvg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kRelx-00027x-Df; Sun, 11 Oct 2020 19:04:37 +0200
Received: from [2001:a61:2478:ca01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kRelx-000KES-7J; Sun, 11 Oct 2020 19:04:37 +0200
Subject: Re: [PATCH] dt-bindings: clock: adi,axi-clkgen: convert old binding
 to yaml format
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        Rob Herring <robh@kernel.org>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>
References: <20201001085035.82938-1-alexandru.ardelean@analog.com>
 <20201006202449.GA2769322@bogus>
 <DM6PR03MB441199FB58D492BE288D3E6CF90B0@DM6PR03MB4411.namprd03.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b8262dc4-2c35-fdbe-7639-38a9e6970564@metafoo.de>
Date:   Sun, 11 Oct 2020 19:04:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DM6PR03MB441199FB58D492BE288D3E6CF90B0@DM6PR03MB4411.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25954/Sun Oct 11 15:58:33 2020)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 11:28 AM, Ardelean, Alexandru wrote:
>
>> -----Original Message-----
>> From: Rob Herring <robh@kernel.org>
>> Sent: Tuesday, October 6, 2020 11:25 PM
>> To: Ardelean, Alexandru <alexandru.Ardelean@analog.com>
>> Cc: linux-clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Hennerich, Michael
>> <Michael.Hennerich@analog.com>; lars@metafoo.de; sboyd@kernel.org;
>> mturquette@baylibre.com; mdf@kernel.org
>> Subject: Re: [PATCH] dt-bindings: clock: adi,axi-clkgen: convert old binding to
>> yaml format
>>
>> On Thu, Oct 01, 2020 at 11:50:35AM +0300, Alexandru Ardelean wrote:
>>> This change converts the old binding for the AXI clkgen driver to a
>>> yaml format.
>>>
>>> As maintainers, added:
>>>   - Lars-Peter Clausen <lars@metafoo.de> - as original author of driver &
>>>     binding
>> Do you have permission for relicensing? The default was GPL-2.0.
> I talked to Michael Hennerich [he's cc-ed], and we have permission from his side.
> I think Lars would need to provide permission as well, as the author.
> If we won't have a reply from him [after by some time-frame] I'll leave it as GPL-2.0.
> I'm a bit clumsy about licensing in general; and I don't care about it all that much.

I guess you could argue that the yaml description is original work. 
Either way

Acked-by: Lars-Peter Clausen <lars@metafoo.de>


