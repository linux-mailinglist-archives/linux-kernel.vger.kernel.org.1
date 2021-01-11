Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA80C2F189D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbhAKOqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:46:37 -0500
Received: from fallback19.mail.ru ([185.5.136.251]:53270 "EHLO
        fallback19.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbhAKOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=61RJng8zaOC5og/ea3xxJSO9PMsAzREgAz/vD7VRuGA=;
        b=xqm3y8XM1zh9/SJRLPyq+hXg2UJmgaFO4CxwxNT1OCOcS58V2hE9JoMmjIUoBBIIR4xVhzaeKGwhQXTgrkxmXwEqtMdlDycUyVUOxrP27iPHz9Oug/v67Nd/MdWR73FWBX6wuhnT0GE5bkJ4cPbKb41za3juBf5xvd1gLOup2iA=;
Received: from [10.161.25.38] (port=59552 helo=smtp61.i.mail.ru)
        by fallback19.m.smailru.net with esmtp (envelope-from <shc_work@mail.ru>)
        id 1kyyS4-0003st-1u; Mon, 11 Jan 2021 17:45:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=61RJng8zaOC5og/ea3xxJSO9PMsAzREgAz/vD7VRuGA=;
        b=O3QQILwnbsR0l/p2CpqCfK8BlHQYAAsqH2bCdCM/1OxUrNdMfJUzJHRL4noF20LYktB4m41DjTXtaRwcDQRaekOIYGWceu8n71GRJNDOrqh97JxNmnXeIPZr5qeOXdNcBXu++ruibChVuaBBJfqAFwQnq8MRFwC+GKBEcA8tuUw=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
        id 1kyyRH-0003ZI-U0; Mon, 11 Jan 2021 17:45:01 +0300
Date:   Mon, 11 Jan 2021 17:44:49 +0300
From:   Alexander Shiyan <shc_work@mail.ru>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: Old platforms: bring out your dead
Message-Id: <20210111174449.86c3848cb62b7aee6b94c42b@mail.ru>
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
Organization: Mega-Milas
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D0E79FBC973162CDDA1A336500443B3AD46BC604C28ED16A00894C459B0CD1B942924C43573D08483DCE2A24E59CC141E814B04C9335DC5BBDF111A57D83EDF1
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A3DED2DACB82E709C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7370F4F695FFFC24BEA1F7E6F0F101C674E70A05D1297E1BBC6CDE5D1141D2B1C5A523B9C8745BADF93E7C23CF47DC560C1A700C0CA6F8BE79FA2833FD35BB23D9E625A9149C048EEC24E1E72F37C03A0618001F51B5FD3F9D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B2EE5AD8F952D28FBA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC00E7B751CB18BCB13AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F79006376382E7E2B5934095D81D268191BDAD3D698AB9A7B718F8C442539A7722CA490C13377AFFFEAFD26923F8577A6DFFEA7C9B187695B4E7C35393EC92FD9297F6715571747095F342E857739F23D657EF2BD5E8D9A59859A8B62972A486E2682F5975ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5F3C1126B37B7DFAA5BA6287B21979EDE1CA7A353723E1211D59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA7517A45118377F5F9E8E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34EE6683D9E546CC62A7498ACA8016DE7EC646CF63217788BC8BF094871F16D8CECDDD7B0435401DFA1D7E09C32AA3244C192AAA20D3AC5A86CEF9FD70A183A910B038C9161EF167A1747E7F3FFB97DCFB
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojmz2Dv49v36hNo9s2d3XeHA==
X-Mailru-Sender: 3BC6B8CA5785035CFA3B5901239938C8C367D548B42017F08BB7378D2B0CDE6902654782B4F284166B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B40E5D90E44ABF6C6604BA033ECC7B62DE122C11DFC52E8EB0049FFFDB7839CE9E8C4BD7E8152C928B94B6DEAC66FEDB4B1034DCD19E9ED5A5C7C998F19DC5AD0C
X-7FA49CB5: 0D63561A33F958A58184E3BA34CFD0F0C6011B37E425544F14308080133023C18941B15DA834481FA18204E546F3947CD6760E474F0469B4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063792238A98CB01235D389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063739589CB99FE13FCFD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636A7F4EDE966BC389F9E8FC8737B5C22494468F871CB5E8762089D37D7C0E48F6CCF19DD082D7633A0E7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7C6EBF3F0004E5513043847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148FA8EF81845B15A4842623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A58184E3BA34CFD0F0C6011B37E425544FDFD9865BAF0EA59ED59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojmz2Dv49v36g9laNxgWIsPg==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005EA165EA48716E380140E65D38C22485A7A67CA5030B5259FA119395EB3F4142A3786569BE0651809D50E20E2BC48EF5AFF3C6AF3E48A3A73EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 23:55:06 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

Hello.

...
> Then there are ARM platforms that are old but have still seen some work
> in the past years. If I hear nothing, these will all stay, but if maintainers
> may want to drop them anyway, I can help with that:
> 
> * clps711x -- prehistoric, converted to multiplatform+DT in 2016, no
> changes since
I still keep this architecture up and running (currently at 5.9.0).

-- 
Alexander Shiyan <shc_work@mail.ru>
