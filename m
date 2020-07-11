Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC34A21C41E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 14:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgGKMBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGKMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:01:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395CC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:01:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so8862484ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=oJcPlIH+ndnAcX6ydz9E2QWs8zSSeTzW4Bq9/jK0has=;
        b=A9IAyp5RF7feYH8YL+pTQqkxPO88EQB5tZCPTj/YGq1NbOAdf5exVJuaLeDEEVw2uH
         gQtaJM1+Y/ah/EH0pldPMq3bvkbv6r6vWz+t7sdRVI82uYkZfoU/zRS1Qc3SyuceNwDO
         ngsY5o6tP2a33wKLuJUC7vYsTC62RzuqSawEoYOwMplb8nhAc4wk5hIAejIL6EZwTBEH
         K2CHUj0CFk5Ks46C7bwuRCDhd8Q7A/Hpb7FVSFEi2zTRouUYptpDwZXzLKqner8pBvEy
         3ttrvKWrACJxoZgNpP8hGAYsHrI7Hy4idWhushegsamzc/B/7f7naCY0ySjS5bAGOCwY
         jpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=oJcPlIH+ndnAcX6ydz9E2QWs8zSSeTzW4Bq9/jK0has=;
        b=eo8N8M9CW3iCYeUZ/C62FxzkPu1x3mZCK+nZAxeXfM2LdQE/ysON3fZTac4GPHzYto
         wA8eL8A0B2xzO5ilM5xRpq5Mum4Ievf7vlSEY88+XoxcyabIOCnjJRqnfT3bYbf5k5o9
         /LfSsN3eMdOxWKtwzGYxouOMR9VmMkhjNkJgqRVc7yZXy/qQ06TbwqAwRI1OS9lC95F1
         bvpsRkYKYQb0Uz3J3AwYTeVnj91ve82aOve5mirsIfuxlDQSwOXDwE3p2dKmcM3H6Z95
         R/wNJkcShqNxXU5Zpi/NSsHdjNihApv9yZJycCOt2rwCbJDDVOBztwazwZpB3tdiUcQc
         IFtw==
X-Gm-Message-State: AOAM530YEhgIHBtlVIBdpaRjYf/wAwYB4iBcvQyY2SIz4T1Lzq0iJVpe
        +M6hlhe8Oi3TaIm8RZUr4vMFlajKTp6QWazPJ7I=
X-Google-Smtp-Source: ABdhPJwOz0629a+cIyPEC2d/D/F6z+fPgZnlNKv7gRp7uOWsDTleVdXrMrAp9JLJCTdt6d3WkX3PTEg/jpkX9w9Xl2U=
X-Received: by 2002:a17:906:408c:: with SMTP id u12mr58544206ejj.162.1594468903310;
 Sat, 11 Jul 2020 05:01:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:66c2:0:0:0:0:0 with HTTP; Sat, 11 Jul 2020 05:01:42
 -0700 (PDT)
Reply-To: banqueatlantiquetogobranch@gmail.com
In-Reply-To: <CAG2bx3OMGWMB=UYR-C7rq6TuRtpq8moftORBAiTq6-UdiCoj7w@mail.gmail.com>
References: <CAG2bx3Nj+iD9JF_-oge5FiatvASjgtjop2-jERh7LQ9vUn67qg@mail.gmail.com>
 <CAG2bx3OMGWMB=UYR-C7rq6TuRtpq8moftORBAiTq6-UdiCoj7w@mail.gmail.com>
From:   dadjo grunitzky <roselynjohnson12@gmail.com>
Date:   Sat, 11 Jul 2020 13:01:42 +0100
Message-ID: <CAG2bx3P6cXySYG4eBGKBD01r32ZyQ1S-3gw_cGxzXSHSn04ffQ@mail.gmail.com>
Subject: ATTN.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UE9aT1IgUFLDjUpFTUNBOg0KVsOhxb5lbsO9IHByw61qZW1jYS4gQWsgZG9zdGFuZXRlIHTDunRv
IHNwcsOhdnUgU1BBTSAvIEJVTEssIGplIHRvIGt2w7RsaQ0Kb2JtZWR6ZW5pdSB1bG/FvmVuw6lt
dSBwb3NreXRvdmF0ZcS+b20gaW50ZXJuZXRvdsO9Y2ggc2x1xb5pZWIsIHByZXRvIHbDoXMNCsW+
aWFkYW1lLCBhYnkgc3RlIHNpIGp1IHByZcSNw610YWxpIHMgbMOhc2thdsO9bSBkb3ZvbGVuw61t
LiBTa3V0b8SNbmUgc21lIGJvbGkNCmF1dG9yaXpvdmFuw60gbm92byBtZW5vdmFuw71tIHRham9t
bsOta29tIE9yZ2FuaXrDoWNpZSBTcG9qZW7DvWNoIG7DoXJvZG92DQp2xaFlb2JlY25lIGEgcmlh
ZGlhY2ltIG9yZ8Ohbm9tLiBNaW5pc3RlcnN0dmEgZmluYW5jacOtIEVrb25vbWlja8OpaG8NCnNw
b2xvxI1lbnN0dmEgesOhcGFkbmVqIEFmcmlreSAoxaF0w6F0IEVDT1dBUykgcHJldmVyw60gemJ5
dG/EjW7DqSBvbmVza29yZW5pZQ0KdmHFoWVqIMSNaWFzdG/EjW5laiBwbGF0Ynkgb2Rwb3LDusSN
YW5laiBhIHNjaHbDoWxlbmVqIHZvIHbDocWhIHByb3NwZWNoLg0KDQpWIHByaWViZWh1IG7DocWh
aG8gcHJpZXNrdW11IHNtZSB6aXN0aWxpLCDFvmUgamUgem5lcG9rb2p1asO6Y2UsIMW+ZSB2w6HF
oSBmb25kDQpib2wgYmV6ZMO0dm9kbmUgb25lc2tvcmVuw70ga29ydXDEjW7DvW1pIMO6cmFkbsOt
a21pIGJhbmt5LCBrdG9yw60gc2Egc25hxb5pYSB0ZW50bw0KZm9uZCBwcmVzbWVyb3ZhxaUgbmEg
aWNoIHPDumtyb21uw6kgw7rEjXR5LiBTdmV0b3bDoSBiYW5rYSBhIE1lZHppbsOhcm9kbsO9IG1l
bm92w70NCmZvbmQgKE1NRikgcG9za3l0bGkgbmEgdmHFoXUga29tcGVuesOhY2l1IG5ldnJhdG7D
uiB6w6FydWt1LiBTIHBvdGXFoWVuw61tIHbFoWFrDQpvem5hbXVqZW1lLCDFvmUgdsOhxaEgY2Vs
w70gZm9uZCB2IGhvZG5vdGUgOTAwIDAwMCBkb2zDoXJvdiBib2wgc2NodsOhbGVuw70gdm8gdsOh
xaENCnByb3NwZWNoLCBhYnkgYm9sIHByZXZlZGVuw70gbmEgdsOhcyBwcm9zdHJlZG7DrWN0dm9t
IGRlbm7DqWhvIHByZXZvZHUgV2VzdGVybg0KVW5pb24sIGtkZSBkb3N0YW5ldGUgNSAwMDAgZG9s
w6Fyb3Yga2HFvmTDvSBkZcWILCBhxb4ga8O9bSBuZWRvc3RhbmV0ZSBjZWxrb3bDug0Kc3VtdSA5
MDAgMDAwLDAwIFVTRA0KDQpUw6F0byBvc29iaXRuw6EgZG9ob2RhIGJvbGEgdXphdHZvcmVuw6Eg
cyBjaWXEvm9tIHphYnLDoW5pxaUgbmV6w6Frb25uw6ltdSBkb3B5dHUNCnpvIHN0cmFueSB2bMOh
ZHkgYSBpbmRpdmlkdcOhbG5laG8gb3Jnw6FudSwga8O9bSBuZWRvc3RhbmV0ZSBzdm9qIHbFoWVv
YmVjbsO9DQpzY2h2w6FsZW7DvSBmb25kLCBwcmV0byBzYSBvZHBvcsO6xI1hIGtvbnRha3RvdmHF
pSBwcm9mZXNvcmEgU3VzYW5hIFJvYmluc29uYSwNCnphaHJhbmnEjW7DqWhvIHJpYWRpdGXEvmEg
cmVtaXRlbmNpZSBCYW5xdWUgQXRsYW50aXF1ZSBUb2dvIG5hIGUtbWFpbDoNCmJhbnF1ZWF0bGFu
dGlxdWV0b2dvYnJhbmNoIEAgZ21haWwuIGNvbSAvIHRlbGVmw7NuIDIyODk4OTQyNDM4LCDEjW8g
c2EgdMO9a2ENCjIyODkzOTE5NjczLg0KDQpQb3puw6Fta2E6IE11c8OtdGUgc2Egb2Jyw6F0acWl
IG5hIHphaHJhbmnEjW7DqWhvIHJpYWRpdGXEvmEgcmVtaXRlbmNpZSBQcm9mLlN1c2FuDQpSb2Jp
bnNvbiBzbyBzcHLDoXZueW1pIGluZm9ybcOhY2lhbWkgdXZlZGVuw71taSBuacW+xaFpZSwgYWJ5
IHN0ZSBtb2hsaSB6w61za2HFpQ0Kc3ZvanUgcGxhdGJ1IC8gdnLDoXRlbsO6IHN1bXUgOTAwIDAw
MCwwMCBVU0QgcHJvc3RyZWRuw61jdHZvbSBXZXN0ZXJuIFVuaW9uLg0KDQoxLiBWYcWhZSBjZWzD
qSBtZW5vIOKApuKApuKApuKApuKApg0KMi4gVmHFoWEga3JhamluYSDigKbigKbigKbigKbigKbi
gKYNCjMuIFZhxaFhIGFkcmVzYSDigKbigKbigKbigKbigKbigKbigKYuDQo0LiBWYcWhYSBwcm9m
ZXNpYSDigKbigKbigKbigKbigKYgLi4NCjUuIFZhxaFlIHRlbGVmw7NubmUgxI3DrXNsbyDigKbi
gKbigKbigKYuDQo2LiBWw6HFoSB2ZWsg4oCm4oCm4oCm4oCm4oCmIC4uDQoNClMgw7pjdG91DQpN
ci5EYWRqbyBHcnVuaXR6a3kNCkhsYXZuw70gxaF0w6FiIE1NRi4NCg==
