Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27A32FCA45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 06:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbhATFHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 00:07:15 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58767 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729456AbhATFEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 00:04:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4588A5804C8;
        Wed, 20 Jan 2021 00:03:57 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Wed, 20 Jan 2021 00:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=3jloOfsfOF+/OCIcN3VvEFRIotLH+R1
        UxiPkPOqMK/g=; b=IT1DW8Rb5AjYeI5sGfdGUyuZSC4Kexr7I2bfbAcBT0rcbTm
        1V2FOSu9dK6EdWFfAptgZ/fjphvRRb0e3teX8jfWzE25guRwJJwkHfCXwGffh/X9
        aYi2AF4vQNiCTZaL9JULH0oDDIowWGMj99KysDCLGemS6DNq+5Dk/KoYVLvVXxbK
        /osEriVoZuuUsKJezz8CpiYmI4E0Fr56qtqEdR9/v64YpBExVSntuz0vrqg8BTsb
        1pNVywKx8AfTzptqAX+sIfPMME/u1ENoCjl1ozfnTIl8KtXBFId19Itg/J63cgEo
        PM8jRzzNgqam5kGh33KgUU0wHpUOaZkNKHxZ87A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3jloOf
        sfOF+/OCIcN3VvEFRIotLH+R1UxiPkPOqMK/g=; b=lz967O/6ucOIULed3VASSw
        DBCrlcmhFWM+3RXHd+arG/3Yz5Pae/oUKHrEE1arYLo21IRbY3BFlX+bsjHyIGZT
        OcokmUJ1UFvL4CwOQKJhuq+WWEDFUCOU0uw0mznT0lL/BvXn565PbLzLaRkIj5wr
        WidZ/4iyStxfyhsaCWYuTRXl3db/2mmEYyoPJlzXg13W3ING0L96+btkIkGbS1kp
        bJP0vhrPYY0gqSgWWGpRszh67Y2XTc88cZz6y+r90FvK7rRgHIfkJt0ogwFldFAr
        SZpRC4kAl9qoVBD5DuVfmLnqsEVb2n0YuIVxgiRUFpHnvt8lGbn+xC1urqsYjByg
        ==
X-ME-Sender: <xms:vbkHYF7bK99YbmwnSa3jxGMdtiLyhAeYLBgX5XwDKqawINlAmTlvCQ>
    <xme:vbkHYC73YHPyxvSwKzo8MnybW1hhYP7dkwDiTDJoXIkCY_bJPUM_apZWxnlGIft_a
    n_WVJGnNdEylmqMMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddugdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpedutddtkeeugeegvddttdeukeeiuddtgfeuuddtfeeiueetfeeileettedv
    tdfhieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:vbkHYMfqJPjwkgq-rpBM0RFro-34vNbU63Kmwy7mvrvJsoNTZImHlQ>
    <xmx:vbkHYOIs_hgKUmgp8pRjZrz5mwuvUbUKAeGkIbR0hT8tr0ZiY4QGbw>
    <xmx:vbkHYJLsJ5lJQzKAO1lrbR-xcfvB5F4woJgNtKBaGVz2OO9yT6db1Q>
    <xmx:vbkHYDBBfCAcOg-kcZX_t7PjnOGS7BB5OfC6XWLMD5Knvw8qcsQUoQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 22641A0005D; Wed, 20 Jan 2021 00:03:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-78-g36b56e88ef-fm-20210120.001-g36b56e88
Mime-Version: 1.0
Message-Id: <b337ffa3-3b11-4269-8d38-e358f0a6852f@www.fastmail.com>
In-Reply-To: <20210114131622.8951-5-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-5-chiawei_wang@aspeedtech.com>
Date:   Wed, 20 Jan 2021 15:33:35 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Corey Minyard" <minyard@acm.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     BMC-SW@aspeedtech.com, "Haiyue Wang" <haiyue.wang@linux.intel.com>,
        "Cyril Bur" <cyrilbur@gmail.com>,
        "Robert Lippert" <rlippert@google.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v5_4/5]_pinctrl:_aspeed-g5:_Adapt_to_new_LPC_device?=
 =?UTF-8?Q?_tree_layout?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
