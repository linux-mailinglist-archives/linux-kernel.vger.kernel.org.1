Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9232FCA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 06:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbhATFAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 00:00:01 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51133 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729334AbhATE6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:58:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id ABF8058067B;
        Tue, 19 Jan 2021 23:58:04 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Tue, 19 Jan 2021 23:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=zqxskKjO+mY+Ddee8kVlG2biEnA/OUy
        hgfrM0eiY4eg=; b=Z+YsHN+livVf3VNh5k6sb+JxqvmscNFvJWesF9jDfDQcrXM
        LMxnBT1j0IJwXKiE/axt2B8oVV1qXmeR0v2hvCUCckyKi92Nla3PVPW+FXN5gYuy
        Owlg000UJ+LPETYXpFpPhTHl2u9hH3NcBUOhCAibB5lBYXrGGmgZTGCfDCKZfCr3
        HTAeR7C1wo5Z4QsxaIdIkg7JnXQhs5A5ttIHlSyggdHEm6ZmCORQO4+Jr2/w7/lS
        ooYdL5Z4I3RjitycN/eq9bJveBrql/PgdAgO8+JrKZdg0oBUazkgepSNGhRxsdri
        liSJpUKxIbRQ7Cpq6dyW9/mobW/0DWNn9sOiVSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zqxskK
        jO+mY+Ddee8kVlG2biEnA/OUyhgfrM0eiY4eg=; b=UXcpzjfM48bwrTh9ydDK/S
        glxCoExz4ly0RBb2F9xc60l5xjOPsVfzAwoqpOyMQ1Ff7WVUZpunswDclPaS7YPX
        Zgaf5zQDaqVDd+76UIEXAD5C4e8O/w4NVDb7OWlH5cmyRUx7H8DcTKM5e+Fg4d7D
        I3SNFfu4b8ZjU32sH0IA3qxg37G1Bj2aujSptozRA6PxlIIoRc7TVZMdcmeo4Je0
        UJaxzUFhOnrjuzP3uW6qDTL2oxwG2WtrHRtuC0K7zh42Fmw0uWlKbKGSv27qCikN
        adJriUPZTYU9fZq/FkyWpPpladeapo1L4o5LVNQ2OmmhUXX9A0kacCS2nyrD2NNA
        ==
X-ME-Sender: <xms:W7gHYIuN7LPIyMQKcsy8wl0gn005hzJ8AEfwyj6ZiEPTgL8f65lO0Q>
    <xme:W7gHYFdC_XD1iDWyH4dVx8fC2Nt2zztWa4a2ZWhubf61U49KBHoIXRcgIPTaCTY7e
    7z99rDBbxE_n1265w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddugdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
    veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:W7gHYDzBAzdFe0I8qELw4p2bAbvNdxW6ses5zOt0tx2ub31uHYJGAw>
    <xmx:W7gHYLOaaDz-hR4CvP_hGAj2U-zLRmKTmdaRzYonZ4qyjYruBLDFuA>
    <xmx:W7gHYI90zsb-5IgQ5Bo411kfnLSF7lGpkTmEoKpFNswyzFVxCmtQDQ>
    <xmx:XLgHYDWl-fEhDPNG2JD9ooO66x_3HDsgj7F-0qjD1y4VPr5wjhsUqg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 74766A0005D; Tue, 19 Jan 2021 23:58:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-78-g36b56e88ef-fm-20210120.001-g36b56e88
Mime-Version: 1.0
Message-Id: <096ac290-3c85-4b08-8741-6efc77745bc4@www.fastmail.com>
In-Reply-To: <20210114131622.8951-2-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-2-chiawei_wang@aspeedtech.com>
Date:   Wed, 20 Jan 2021 15:27:43 +1030
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
Subject: Re: [PATCH v5 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> The LPC controller has no concept of the BMC and the Host partitions.
> This patch fixes the documentation by removing the description on LPC
> partitions. The register offsets illustrated in the DTS node examples
> are also fixed to adapt to the LPC DTS change.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
