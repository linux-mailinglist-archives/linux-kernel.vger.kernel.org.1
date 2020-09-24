Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8C27717C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgIXMtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:49:06 -0400
Received: from sonic305-21.consmr.mail.ne1.yahoo.com ([66.163.185.147]:33103
        "EHLO sonic305-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727759AbgIXMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600951741; bh=yTDSmKzAyZiY04KpcUnSYGidXb718bwlWZW7TvVpHhw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=XoIa2u09BbTFcSNHIqfY8pJXiRz3rJlM8BzawaXGmjpmvlxi4C+nStW150ICPLrM9nHVTbfoQJCAgGPSNksUN33B2z0qIvTqkVFDyniUxfVgyWNhhc/3IIQ7A1K1ghrQA3ySY/bscSv1xIig6oOJmuBBMMBtZjFxO0WujaAwzbD99VnSB3fOvKPCI1YyADUsFuGj4ZlvHdPU7nC37kG3RcGIJ22fHQ1neS+bokbUezsAuKAP343imivwSbWNEfwS5EnUMLd9U+U4eChZQGtMHODjthehmrTaJKS5Puwv4eggClYWsdwPTR22Pjf0pVjKX1gMMnBp+72v73yptMCUJg==
X-YMail-OSG: k6R_o_0VM1nvGNWIhjxjeV58nrVpf4wN9bgYLWYfAW2BgJ7deRIrmC2P4Z_Lc7L
 V4PEYM9BXrXXbDTAxNIi1D_fhG35a1tgGyrfk52gvrcGCDVSV8qvTGw1.88iHKjar5Gr5dL3ZLB8
 l199dqqNxUrdzwElyknK01WM2NRCxUdymAzXaTw6gL3kdOHJJ2hepIE4kVYeszn2PiFwur3UboEC
 Y.Xag1WhdJ.q7URFKNLGUFjnDHkociE9TGGn1XNDhJPD9wRGzRCMy1U4ufPpVlkgsYvCGHLFY29A
 ASftXiozqOkWbgzz5Hu8kENyRuQyvgOISYmKigk.9SsTN3pwWjsL_qCCP0ppUv9f1hnmRX9NgBYp
 1fAFC87ktgq2Wv41soY7I8DHxk.IdFnWTM0yvUDXbteLu3d2UPxaPyomzr.PXIYb7v2v2Gk53Nu9
 pc2yTHbKQaJbIjqS4q4aEr1nGbJOoVUv1ZLbKglr3Zbz1CseTbLqCLgFWuOcjPoyL7NZ1WF4Wb7p
 bqdxvCNgGkBPavJrgS0zS7hqYoNpnNqJPjVgNb5p4Ywn.iGAD_2z6OOze0V7XJ95_2IoInlxOWRD
 0oxBh4PTo2gaJqw0g1VwvrMv003JxP1vrRX9WVyj0y33IY0TAqH1m7RI5SY3OuYf4AxNtAEDLfk_
 uVttoJuFV6ZxV_Si7pJ5WoX_3Y9N83vdEWs0C.oNNAkz41C2XuP8zINuyyM1BEE6h3q0Dpz8uq0o
 UO4309k7S_ilBDGh3SvUeDJvRZkHDPe3zfMnT0pn2m.ybosa_xnWGSbST4H5eYh_8vmsaoPo0ftN
 U9MBdtUmKhbPcdqZdmTf7dP1kWPK4cOv6o6a_XsOLctAYsBNQAga0DOERxcFAI68DbAvzocuGAux
 0.V327hReftx67HqXy0XjVY6ttTn9.bvNwJKBIEPAO0h1TXK1qj6Nsq2_V8fbAXUV42WhGnDSGRF
 7UUjbiQS2W5.wE1ylwMljgUHPlVZ5Av.o_N5XDrDrjwkBbzZKiu_jTGVg7t2r8iOYiw72esbhdkK
 tU7Ful6rYITciGv56agmkOG0jvAtquABKaq3zk5e71RDu7qgZTwIwwjSfqJnmFTKIoQg2Qn_Yfh1
 SRiLl6tL7qz6kBm7AHuOaQsrXW00zd2v_9iZ2d.GIOD4RrZC6gr4Y3sZoggXe.DoMXv9VhDauDaB
 4LgP7VpNjAlWyPU6M3bf7fsvqjNU95PbFzYPGBjmY8kdIYO8g3SYKA6AkGI1wOiYuAJElGOgslAq
 mCiHz3XFQER1c7L50jDP1OwlIMnrRKq.qHiE42pnGIBqHzXZzRBitylk3jFXd.OzUD8Q.gt.iHdv
 oiiXc75Sk2b2Ihtitsfqrv9quWdPfzJeoWfkAQCyoAr0IyaO3dcEA09EKKPnuzPUcVgbe5_1sLIn
 sR4HB7Z43mY.xBUyrOiiQXO72INN_BFtNSHqv1XykW6JidXOrtWHDWOjj_u8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Sep 2020 12:49:01 +0000
Date:   Thu, 24 Sep 2020 12:48:57 +0000 (UTC)
From:   Ahmed Hannan <mrahmedhannan03@gmail.com>
Reply-To: mr.ahmedhannan@gmail.com
Message-ID: <67613788.264469.1600951737567@mail.yahoo.com>
Subject: GREETINGS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <67613788.264469.1600951737567.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 5.1; rv:47.0) Gecko/20100101 Firefox/47.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings

How Are You? I Know That This Mail May Come To You Almost A Surprise As We Never Met Before And Please Before You Proceed Reading This word of your own as a human-being? As I have gone through your profile.Well I have a deal worth 14.5m$ dollars  from the dormant account in the bank where I am working.so Please if you can keep secret,I will give you more details and the nest thing to do,

Please, you are advised to keep this as top secret as I am still in service working with the bank for security reason until we conclude this deal successfully.You can open a new bank account for this project,or if you have any current bank account it can also serve.

Note: this business can only take the bank 15 bank working days depending on our seriousness and commitment with the bank to enable the release of the funds to you as the next of kin to the bank deceased customer,
I will be monitoring the whole transfer process here in the bank as an insider until you confirm the funds in your bank account,and thereafter; I will come over to your country for subsequent sharing of the fund according to percentages indicated and for any further

Investment,either in your country or any other country you may advise me to invest.Write me urgently so we can commence all arrangements and I will give you more information on how we shall handle this project.


This is to enable me to locate you for my own share after the  transfer .Waiting to hear from you urgently.

Mr.Ahmed Hannan.
