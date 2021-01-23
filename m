Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDF6301396
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 07:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbhAWG1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 01:27:47 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40837 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbhAWG1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 01:27:36 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 80D835C0083;
        Sat, 23 Jan 2021 01:26:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 23 Jan 2021 01:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=U
        z8v846aA9eOU/XvvproYzUdaenbuCP7/Eyc2BOJtnA=; b=fDhKFD/C4QCWPQSvj
        yPezBFdQrsCgTT2lWS8uWaqW6IsXVVTnSzWC9/edS7J8JD049oneIYiV+X5ztSTa
        qxSlPaGIdWhf1DFBtVZhNSfitVrdUDm6y7XzJ6hJEa3wO42AVvh0hncoMPsNO5Ml
        FbJHQ0M758PtXVPyenjn01gpsILjVMJSEremE2nDHr5C8sYqak/ZS7LLUn7Z4P+t
        W8sGxYBpyv4h0PdFcY00D88FEVw7SuSEmkHossJ67L8/oh+9b7aUj7kvzJulMazF
        z/dc5LBBI0hNskqLWSR5EH/Cu3k9k2HIlQI7nYl/GoC7Gvsblv/dPDPMUrgD3o2c
        7C8SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Uz8v846aA9eOU/XvvproYzUdaenbuCP7/Eyc2BOJt
        nA=; b=nUVNdlRAtH0t9inZtYXzFtxT/8X8UwJqROXqMX4D2E25TsM8NNPIcBGPc
        wweYTkKsFxE/r6A4ufixPawRJ9gZxozhap4I0CQNDu4SQofhHbFVLvt4RAA9B8Lu
        toy4IPlEXWfBJdOzWkFTH99VAI6vG9T83iR6W/YfTYZLCOgjhQTMgtlfWTeWmWWE
        k1iDu87TKdOxO+9XHAjySwh378ar5ju9tUMUdCYYTjapszPQuBL8eecx8o5LIsb+
        o/ZmBQ5saSjCGjOTtXDEjYE/gd93YuSRUsatI3wfmmKTh8ssys4MTwlaN3NPY0jc
        QVq5vPfjUXZKGSsjeaDZJF1z/VO7g==
X-ME-Sender: <xms:k8ELYJML65koE-7K-ekWTecBOkkASwd9y1h1mBco_6qybIBETpoGzw>
    <xme:k8ELYL8b9CJAAFvCKhjK_geZVhP2-2e1OIqaB4R-E7oT0heRQ1F47kThjUyg2oIop
    4ADA616JqOOA_aYqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeehnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeehjeeghfdufeefteelieeggfehteevieetueffhefhffekuedvffev
    ffevtedufeenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:k8ELYITCUWBmNUSqRBjumnoEAiykKr4FOf0Y8p-YVa-Kg-95L-E2TQ>
    <xmx:k8ELYFvWJYajeULLyZvb7VKsOlsi_woPVIRw3-dC5PolISpLUEqd1w>
    <xmx:k8ELYBfL2d7HKN--uDrLmbVMCbFa2vmKtY1Q5OetXDS0QI0qgchGSw>
    <xmx:lcELYLsTKO0wx46ZScD2CqjoEYGvJkDAhualqPzi2R3E2_b5O7eBqg>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 790D8108005B;
        Sat, 23 Jan 2021 01:26:27 -0500 (EST)
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Marc Zyngier <maz@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210118055040.21910-1-samuel@sholland.org>
 <161126112131.135928.7664552660827790510.b4-ty@kernel.org>
 <08e9bc97-c18d-9b8f-28be-3892d77730bf@sholland.org>
 <20210122104705.bo2x22ef56hdj26q@gilmour>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v5 00/10] sunxi: Support IRQ wakeup from deep sleep
Message-ID: <52b9c9bb-ff75-d1e6-e198-0d388d1c6d73@sholland.org>
Date:   Sat, 23 Jan 2021 00:26:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210122104705.bo2x22ef56hdj26q@gilmour>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 4:47 AM, Maxime Ripard wrote:
> On Thu, Jan 21, 2021 at 07:33:54PM -0600, Samuel Holland wrote:
>> On 1/21/21 2:35 PM, Marc Zyngier wrote:
>>> On Sun, 17 Jan 2021 23:50:30 -0600, Samuel Holland wrote:
>>>> Allwinner sun6i/sun8i/sun50i SoCs (A31 and newer) have two interrupt
>>>> controllers: GIC and R_INTC. GIC does not support wakeup. R_INTC handles
>>>> the external NMI pin, and provides 32+ IRQs to the ARISC. The first 16
>>>> of these correspond 1:1 to a block of GIC IRQs starting with the NMI.
>>>> The last 13-16 multiplex the first (up to) 128 GIC SPIs.
>>>>
>>>> This series replaces the existing chained irqchip driver that could only
>>>> control the NMI, with a stacked irqchip driver that also provides wakeup
>>>> capability for those multiplexed SPI IRQs. The idea is to preconfigure
>>>> the ARISC's IRQ controller, and then the ARISC firmware knows to wake up
>>>> as soon as it receives an IRQ. It can also decide how deep it can
>>>> suspend based on the enabled wakeup IRQs.
>>>>
>>>> [...]
>>>
>>> Applied to irq/irqchip-5.12, thanks!
>>>
>>> [01/10] dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
>>>         commit: ad6b47cdef760410311f41876b21eb0c6fda4717
>>> [02/10] dt-bindings: irq: sun6i-r: Add a compatible for the H3
>>>         commit: 6436eb4417094ea3308b33d8392fc02a1068dc78
>>> [03/10] irqchip/sun6i-r: Use a stacked irqchip driver
>>>         commit: 4e34614636b31747b190488240a95647c227021f
>>> [04/10] irqchip/sun6i-r: Add wakeup support
>>>         commit: 7ab365f6cd6de1e2b0cb1e1e3873dbf68e6f1003
>>>
>>> Please route the dts patches via the soc tree. Also, I had to
>>> manually fix the first patch as it wouldn't apply on top of
>>> 5.11-rc4 (which tree has it been diffed against?). Please
>>> check that the resolution is correct.
>>
>> This series was based on sunxi/for-next, which contains commit
>> 752b0aac99c7 ("dt-bindings: irq: sun7i-nmi: Add binding documentation
>> for the V3s NMI")[1].
> 
> I assume merging the DT bits alone would break things? If so, I guess we
> can wait for 5.12 to be released before merging it

Patch 5 does not depend on the new driver, so it could be merged at any
time. Yes, the remaining patches would break things if merged without
the driver.

Cheers,
Samuel
