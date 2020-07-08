Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB23218ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 19:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgGHRq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbgGHRqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:46:55 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95E0C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 10:46:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so51474181ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EJMc/xcXVumWcdAvZFlSMeCrBQVeyLIyiuzzRVYBYfk=;
        b=iLiJQd2TxXXL+NzKuZA6CUKbcVXBYBGdH9YzLfEKWnoR5drlL91HeOkB/Di48GSTB1
         +twLeElS2fx4+0kuHjT5DcZOPSAG97K0fzPC7U1LPPEgMViAWDM//NmfOwSX+c+2FdJJ
         jDatTnJLmdtYWKUsnWGl7+DMfm8EitQ/j2m21/N3WX1ADjZMRvTWIfEo+LUmbGWWx8ts
         hZ2AYxrOujlXfOhsnl2wpeH60ucsLl56vojwCNYvxR5BYSeXqpxNBBkbsXHSYjtCVNQ3
         ZMOpJZByPJUdnUy9usPJ1H0MealoSlgVvzr/s5Pf7DQeieF3nu+On9EzN3raFIHUY7Z+
         2LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=EJMc/xcXVumWcdAvZFlSMeCrBQVeyLIyiuzzRVYBYfk=;
        b=E14BTkEkZ12sNPz5s/HDzhNYq3Oad3Jxolecj4aAHCdZ2oIoYc8DKgC3gvLw637s4l
         JYwSaJnZR190oT1BmRbUqCkbQhSlqHj+TDkAAuMrqKWjqbhNPk6vBC0kq3aBRMiU7sLo
         i0xX5IUidhFhxYObD0gclmYpnsSWC3iQIBT4Kv/HANr0r6h2MDnRzmGP6lT243Rp8j4M
         uE+NcyXvQpPQnaQYom+GqdwdNCIKJxoofYw0qvqI+43GdDXuMT/EV0waYfM5IkCcVtTf
         6gDV6uZBlzmwnuIoLHgfcr18br59um4TFGb1okT12rddvIbo8iCjdqs8btcW51CoMlFp
         R0kw==
X-Gm-Message-State: AOAM533Xgh3Rt62PK1bPX3HdZMoyeD3UYHcXSCdfWmzLXSyqpKuKt5Fj
        h51bDnWla8yOCMZr2C8c3/0/iHbcLX0200aCNQk=
X-Google-Smtp-Source: ABdhPJzPaEkRjkIpKa5qqlfd2Xwt5LlPLnEKL/3twAIzcRP07TTAx/aTa2eiKMCMSyu17MQ3nQOwii3tEZu8i12gvYQ=
X-Received: by 2002:a17:906:e215:: with SMTP id gf21mr46174293ejb.310.1594230413759;
 Wed, 08 Jul 2020 10:46:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:37cd:0:0:0:0:0 with HTTP; Wed, 8 Jul 2020 10:46:53 -0700 (PDT)
From:   Keen Maxwell <Keenmaxwell19@gmail.com>
Date:   Wed, 8 Jul 2020 19:46:53 +0200
X-Google-Sender-Auth: X1iX0kWDGqYme9Ai0bgXlXWIhsE
Message-ID: <CAAQKjW-Gs__fP91AZ23CwBbi9bBgO5V2LnrpFmjsUY2B2i2vdQ@mail.gmail.com>
Subject: =?UTF-8?B?16nXnNeV150=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrXkNeg15kg157Xkdeo15og15HXqdedINeZ16nXlS4g15DXoNeZINee16rXoNem15wg15HX
m9eg15XXqiDXnNec15Ag15DXmdep15XXqNeaINec16TXoNeZINep15DXp9ep16gg15DXmdeq15ou
INeQ16DXmSDXqNeV16bXlA0K15zXkdeg15XXqiDXkNeZ16rXmiDXp9ep16gg15fXltenINeV16rX
p9ep15XXqNeqINee16fXldeT15PXqi4g15bXlSDXm9eq15XXkdeqINeU15PXldeQItecINep15zX
mQ0KKGtlZW5tYXh3ZWxsMTlAZ21haWwuY29tKS4g15DXqdee15cg15zXp9eo15XXkCDXkNeqINeU
16rXkteV15HXldeqINeU157Xk9eU15nXnteV16og16nXnNeaINeZ16nXmdeo15XXqg0K15zXm9eq
15XXkdeqINeU15PXldeQItecLiDXnNaw15fWt9eR1rzWtdenDQo=
