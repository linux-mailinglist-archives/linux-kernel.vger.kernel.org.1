Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7CB2567F7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgH2Nuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 09:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgH2Nul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 09:50:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F24C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 06:50:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so1923882ljc.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Voo6yU4jc3W+0dUjEsgBAfEIfr+ReL8xnLzDolA9ivE=;
        b=b1aiUjVCGyr120Iy2nwfN1btS0NXBaB32EIBTlhi2Z/VIwoC+Ry5SKmBvs5Eje1NOQ
         Cu2dXqMTP76IMMSVAciPG8HXsx5MFdc/0bmFj5C0W5I83pZRhYRqPnrWacn7Si+qtHZ4
         AUzcDLdUHXxeV1S1cDAvfSnTVADFpg9F/HFYXYv2F19kALmyGMnjLiw/fZ4rjCND9ZfU
         NG4i4YXI6eUy9EkG2h6DjSJnsd2XIF+wGmt06Qd8lSeYlGRUS7vPgVXqofIwF1BdCybx
         uwlmM7oYkIfFsNc6fMtlYnShJAzDm6DjJNqztdE3CEdCneygBuTv6EF6lxJ33/ZKjGAg
         /ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=Voo6yU4jc3W+0dUjEsgBAfEIfr+ReL8xnLzDolA9ivE=;
        b=RPo+L03U0cPTfw2yNJE8XSkF80A7r9leOW877RXys8pPDTMtktHd2vuu9PpoRpctBP
         CmIEVIjkztI/hRiD1oMCAOlxEZBSw2VndpzPzoi8EKvMDTzKBEwQJinBntqwwUmEa/7I
         wuzpUjRd45QQiU1TV24l8aheWbgVcUQYV92N43+Oii5SS9xi+hH8aGrT8yr20Jxw2ZoT
         qP58rhRzXOG1Qf60b9ZsiEGVOjx3umrPmBt0O5YQdkm33rB2GzZQYHeuC8k7HiNSDPXk
         1CF3Fv70IMDe8yLBMP2jf5HGvI+yEjFQa0AUXWLXXMhrJ08mtpyGzMqtYZne49Ssod8P
         9S1g==
X-Gm-Message-State: AOAM531SyjbtWlRri6m/+mPgCr6VGz6BZGRjqZgBQ7gMsRmbEOQ7B7fF
        vCMkeFqE/OTdKU78MeTtWH2unrPbr8HoY4KZ2w==
X-Google-Smtp-Source: ABdhPJyqBh6C2KcRPUuh6ElmVNDJut3+HlWWa8u2v0CNjNBMC2sX+1ubCEaLdVETFWn287kKruRW9LKqVFTmLMbeHT4=
X-Received: by 2002:a2e:5c5:: with SMTP id 188mr1477001ljf.466.1598709039025;
 Sat, 29 Aug 2020 06:50:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5892:0:0:0:0:0 with HTTP; Sat, 29 Aug 2020 06:50:38
 -0700 (PDT)
Reply-To: moneygramdepromo@gmail.com
In-Reply-To: <CAP2YtbmTZ=Veqa5N160J-VqdzxnP9PURCWV5qbP53+d84p2Q0Q@mail.gmail.com>
References: <CAP2YtbkNmib8SY5jo80=uA86thHscC6-XWnpYkH1mBwAGOFEPg@mail.gmail.com>
 <CAP2Ytb=BTCy=6KeJ9DBs+aoB0eRakCw=SsGFTbBu7_gidYaA1g@mail.gmail.com>
 <CAP2Ytb=gnjq0dHSMHydVkRvAHeWnygrRLRbM37JG85x5neLPYw@mail.gmail.com>
 <CAP2Ytbn=9GPiiAGqUzHAdcfBE+ZnHv=KcjqAO8oABbBnvg62vA@mail.gmail.com>
 <CAP2YtbnEHQChgRAue=NmCbaLfZ1eRGBit6Etr-0DCDXR+zih1A@mail.gmail.com>
 <CAP2Ytbkgp5xZiX+OY30kT-E2EH5wuAEWinZZnHFzsjGSU3+OZA@mail.gmail.com>
 <CAP2Ytb=NV5NpPdMG0Djp2JxqjuAd4CXNgqPjptycHcWg3hAisA@mail.gmail.com>
 <CAP2Ytb=eE_tsvG_c95D-taqP55p_ND=QzWC_XkcN4XF2077Rrw@mail.gmail.com>
 <CAP2YtbmMpo7L+89RWDOQMUhoUMVFAtYAU78biBdoghgMucjwEA@mail.gmail.com>
 <CAP2YtbmLiHweC7XJ4y61+HO5GUWWN9m1opvcNwAeqYAzAiYJrw@mail.gmail.com>
 <CAP2Ytbk9xERKCPCbXLrjbGMjMunF+p4Msy-gn8VBSwnK26dxSw@mail.gmail.com>
 <CAP2Ytb=AMZf86dJftz6dQ-xaYpBodXtpH-rc5_7zXUww+SdM9g@mail.gmail.com>
 <CAP2YtbkL2DvTvTqe2HpvnNqn+j_R8BdE_n3qQSD7oWLzdDsOLA@mail.gmail.com>
 <CAP2Ytb=eNXwS=NWErJLVpH_9v_z0CyGAuPm9MAaH67QJ6E7YUg@mail.gmail.com>
 <CAP2YtbmAJG214A8cMEURA=nWswRqV0=7Nv=Pr-hiEcSfNEfV+w@mail.gmail.com>
 <CAP2Ytb=jh2bfTR2+bKimTHVt9T+fXs2a8HVbBZ8WZWSj5c7QsA@mail.gmail.com>
 <CAP2Ytbk0SyR_AZ0So7u1a2+mmL631mb+2p1zoSK2wgHnsoi0iQ@mail.gmail.com>
 <CAP2YtbmaEFNy=yTnLx9HCq4Y27eAqc1TVY+CRJJMGxnavFjDDg@mail.gmail.com>
 <CAP2YtbmsWYFZwne0QpwyGT3FTB6y88dqsBxGKq_Ar=UqLryNMQ@mail.gmail.com>
 <CAP2Ytb=oOBvk2pn8bpKdiCg9gNFRm8HjvKpGUTiFhvcsv679PA@mail.gmail.com>
 <CAP2Ytbni3E5YoHX_pwLr7s8tb+Vf30jk8kZK=JeagZgDWq-HqQ@mail.gmail.com>
 <CAP2YtbnXP0zD1XdyAv=YEhLXJuYsvPi10gNL1OtBbeYLVA5N0A@mail.gmail.com>
 <CAP2YtbkzgWLaadiSn1Jf5ROD6cP8ecNTP3ARuBWeV2MhJFSg-A@mail.gmail.com>
 <CAP2Ytb=DwFo5fbEcibODrktbdxzgPp-U8YWnnJPKzL5KJhLtpQ@mail.gmail.com>
 <CAP2Ytb=MSeCt0dwvA-fFH3UoW-htYkRzrm9BPeUa3ndEX4gyYA@mail.gmail.com>
 <CAP2YtbngC-5JaD9P89J5=rGQ7tJMh=Nh-oHEjT3FK=8WCxmW8g@mail.gmail.com>
 <CAP2YtbkhNAvBk7us2tvJw5Fue1mQhy9q1Oc4fWzF_9ykzJxZZA@mail.gmail.com>
 <CAP2YtbnYDscJ7HSOeS1UNEUrVTqmq8uwz86Xc0bFiF8U6txi_Q@mail.gmail.com>
 <CAP2Ytb=2xYw3gPB3vS1BWFxFHk6fb5FuSC1GtXe9MiKSam788g@mail.gmail.com>
 <CAP2Ytbkat-xT9by==8=NG3CnwsP3uSs6DFoPZyLcdHBC4Qvamw@mail.gmail.com>
 <CAP2YtbkMxh62s2sSAjRmVs3PVWZMPPEk1s_qt6X11FOO38TS6A@mail.gmail.com>
 <CAP2Ytb=VMF9CZSE_Q6OwPD2uvaTkr1Yw3T7O-PN2_CHAwXD2jg@mail.gmail.com>
 <CAP2Ytbm9FF5xL-XTs5XucXzdfDCVr70tVbz7Oj--3K4yUT3rJA@mail.gmail.com>
 <CAP2YtbnJmu0PYR60_++Xmy8FUYwAXZnpSK1nKi-zHbSpn4dxUg@mail.gmail.com>
 <CAP2Ytb=sdK8bz6dPB0MQqmd=74juK=26H2fwN=saXC+ej+kkTw@mail.gmail.com>
 <CAP2Ytbky1aP6r8+f8gWpTR1OY+mBhPJ+FT=H4_2EqTUO69wEoA@mail.gmail.com>
 <CAP2Ytb=drYHFPaQGP6JC12axGqPan5AP-Fk8m94RHwT+drYpvQ@mail.gmail.com>
 <CAP2YtbmoW8M1WPGYXFYDyJT5q_ogkXXJ_EwnA3Y3nyWaBpf53w@mail.gmail.com>
 <CAP2Ytb=isneefeLrcXyWNakbGQwqcZG3ekXef_PUSY7spuDm8w@mail.gmail.com>
 <CAP2YtbmEet+QEdqaSoyC6fznrzdo3NWCr8bwso7SUXcom_bcZg@mail.gmail.com>
 <CAP2YtbmXw3aQu_sUkgTtsHb6Wrz9cEJKcu4yhnOqae3EwXSEjg@mail.gmail.com>
 <CAP2Ytb=zgHUEfv8QtRY1MYhdOJnmcDqym2gohmOV21nvqGTZMw@mail.gmail.com>
 <CAP2YtbnRpox4x08W1HBDzN8rgUnq7iFC4b1A3EZJYxj+uPZ1bA@mail.gmail.com>
 <CAP2Ytb=GtZCtayCLmMvY31jkb2jF7p_xJ5qH0RrwdiYts2Kchw@mail.gmail.com>
 <CAP2YtbnTj_QhOwqLe3F5hAMEJfhut+-wUHdE6iPg-3BuJ=p7_g@mail.gmail.com>
 <CAP2Ytbkr8Kr9AQ7rP77Jh1a3kpy2DeWfRkhOnxyA30-2fyBohQ@mail.gmail.com>
 <CAP2YtbmVVxaUbioEPr56xXMuG-UuPGo3DR2zk1zqMgasYszGJw@mail.gmail.com>
 <CAP2Ytb=uuMLuLFtB1A59CUvL=z7Fx3OStJ5zEygrQKO-rzuwjg@mail.gmail.com>
 <CAP2YtbkCobpGXj6xcCSDX=U2T4g34JWJVjxv=prWM62fzK=eGQ@mail.gmail.com>
 <CAP2YtbnX35673=kUmmR66nr9p8qVimSNF=vk2h_K6s4-H4y47Q@mail.gmail.com>
 <CAP2YtbnCW1JOOpQ2EiSbOzMLEZzhJQ72Ba82g530Do61Y5=qKg@mail.gmail.com>
 <CAP2Ytb=PqcRWV+LnCijXB-=85LzfCzqrUx=wsEN4EeBLMO3Byg@mail.gmail.com>
 <CAP2YtbkC0kED86BbVKMUW9T705CSckfBR=kVLFM_M2zQTinycg@mail.gmail.com>
 <CAP2YtbnRqO-QUJnTaOpaH1fNPsfqbrcApPwqLnoEOsT_F5jGgg@mail.gmail.com>
 <CAP2Ytbnr2_sJ4Rf2Hbi31fMPOD0AQUo7i6rakOzf08RZ-N1hFg@mail.gmail.com>
 <CAP2YtbkWj0-cRru+Pc1oTzxRNh_mYNtSP3upBZUR8MoSJZODrw@mail.gmail.com>
 <CAP2YtbnBLrH1zxX97M-r1wtLRMexgJsqmwaNfBZun+=HqGLUWg@mail.gmail.com>
 <CAP2YtbmsvHfYBKpUgw5C7pp7KKuzP-N=x0M1=wfxEtRGLkd2TQ@mail.gmail.com>
 <CAP2Ytbnsg4Z+q_76-iXEPNaDAaNDf7=yN-fgV8aeZMCgETgX5g@mail.gmail.com>
 <CAP2Ytb=5SDexhQzLiKsR-MA+4pQh0CYCzrCfoa98quiMTdJPgw@mail.gmail.com>
 <CAP2Ytb=JA2cTxp3w6e5LSFt952Zc-8bj=P5pZGJFcRemT+5+nA@mail.gmail.com>
 <CAP2YtbksxGWcfF6e9=HRDm72evZjHbgFNegxNOWxg+KAYK2JBA@mail.gmail.com>
 <CAP2Ytb=wRuFDtC5N_7=3=oy=ekGX+9fWP6Nw70Wegx08kLkvNA@mail.gmail.com>
 <CAP2YtbmNUzNV5s_hBh9aJ09iQC0LaB-b9+3cBrk0pXUmDteXxw@mail.gmail.com>
 <CAP2YtbnxmQynghTTLkPHcnEz3U1VswM_PKrHCc8eODzq_7GB7Q@mail.gmail.com>
 <CAP2YtbmdH8+y7dzFbuqh6E9Te6ftdWrA1p_YhknPT4rcnO6fSA@mail.gmail.com>
 <CAP2YtbkpL7=2PGGNnVdSo3P6mZ0A2Uj+Hxs9BxGOf5xA=iS4mw@mail.gmail.com>
 <CAP2YtbnscNd3L+0YroDc+O3jTsAcAedV0kYXUgjr6M5iQW_gdg@mail.gmail.com>
 <CAP2YtbkycbE0vtqf-wWwD_jMFVJqFjJVuXKmd6y2SKEz8A=e_g@mail.gmail.com>
 <CAP2Ytbk7xGux8v7t_dK=b-Miy53X7ebq4Y1ZOn2icVS44wBByA@mail.gmail.com>
 <CAP2Ytbm1MuMSar5QEiuLoYZ4DQmXYHBdjEr24Mk9kzKEem4uZg@mail.gmail.com>
 <CAP2Ytb=MY4FeocOTdR6BRq4o3gc=UjjdgVNBN=SoexwWQ5AD7Q@mail.gmail.com>
 <CAP2Ytbn4VkdEz5SEKO63eBtPa8Psp9oOtwahiHmBh2inYqG3XQ@mail.gmail.com>
 <CAP2Ytb=iHctOcdvz4SHCXjLLppsFREY0Gpy1g3ues5-p+ARd9A@mail.gmail.com>
 <CAP2Ytbn3ShGdSjABVX1G-hLMzE4J8TA5PK+e56m+HM+k3eTMyw@mail.gmail.com>
 <CAP2YtbnTmvCuFgxetC+zP+GnxKA1FNkYsT-F+q4LGHTf6B0Qtw@mail.gmail.com>
 <CAP2Ytbm13YB5ggkR1pCbO+ftO=fEafedirheeTtKSChuzggVHQ@mail.gmail.com>
 <CAP2YtbmYj2cjQQeiR6SWWO5rCVvjbpLkt8Te12QF6vBPqEpO4g@mail.gmail.com>
 <CAP2Ytbnx0G+KgRJFXDYEqPi62HwXiKnSgSPW_vqgtmEx2r_uZQ@mail.gmail.com>
 <CAP2Ytb=cMLc8LHbp5SC6AQoKRTYHPnx_vue7zaEfcu9CWy3YXA@mail.gmail.com>
 <CAP2Ytbk0QQO7MwQQg7gWhnbTPDJAz1VuAswCQCpAvBizOrtXVw@mail.gmail.com>
 <CAP2Ytbn4v7uB+Qj5C50mZhhw0h0=DSmj9Mm042H9iDSOzeLimA@mail.gmail.com>
 <CAP2Ytb=zGCv=zNg=-UrXJA3w0YDgcfxywNaAvWWeTFE34htP1A@mail.gmail.com>
 <CAP2Ytbm68P+kx_6x1-3hXqKEHpeBO5axEgb+86Ee0ZapjqNxYg@mail.gmail.com>
 <CAP2Ytb=6bssaYpCnVQd0UYGdcfevyJGE9VMvLcoPfqbPDepDGw@mail.gmail.com>
 <CAP2Ytb=eos8NaWg+DSy_JPMb-gsOjA_pX6y3uxEZ_MbKudKx=A@mail.gmail.com>
 <CAP2YtbmtRD4qW262aiMj0Apepv_Nod0kSeaJTVE0=n=UtDULJQ@mail.gmail.com>
 <CAP2Ytbm=g_QxTwR+jeT3m3pn_5m=vXN9LKD4BAGeOXnpuhfTfw@mail.gmail.com>
 <CAP2Ytb=jC_eAq0DHPYNhqf_Gkb-dzv9Z99FHJJkFYZQOZ2KiCg@mail.gmail.com>
 <CAP2Ytb=mEXL56tQy2Y-T2=3n_XP-ig3PXS4qzt0cDM7vP4YHvA@mail.gmail.com>
 <CAP2Ytbm0GEh5ieYABi5V130Mn72ENanuSjrDjhZZRobH19eZvg@mail.gmail.com>
 <CAP2YtbmS+CnHctnZwrY44+8op_jY1T6zAdtRVRdOAFTGNMoU=Q@mail.gmail.com>
 <CAP2YtbmYUp99BCYfxX5szire_QOaJekN0-dQxybRkYZxoRkgSw@mail.gmail.com>
 <CAP2YtbnVHDHnLcHRgehiyGLsiQE7=xmqE9D4qH-91ieP1n6s2Q@mail.gmail.com>
 <CAP2YtbkBKrs0Bg_rE5fu8Fh-EZFGnOYWuRb-g=wj-zX9WAgV7g@mail.gmail.com>
 <CAP2Ytb=Q2k6grvAS1aMKXd_m08h8LHGrtE7NWF8AmjbQE8WN+g@mail.gmail.com>
 <CAP2Ytbk6cC7oL1qpFDc-3FfFvj36-Gjd-RPGe5O1_97MXAYfbQ@mail.gmail.com>
 <CAP2Ytb=B4xTzqKOZ4v-2nD9StKrDh5Lxo7LSKRRCFKZPNXK7qw@mail.gmail.com>
 <CAP2Ytb=xV3ZxJRVo7gAqWuMM-F3EEu1XTMkqLVmJbtp4V1RvqQ@mail.gmail.com> <CAP2YtbmTZ=Veqa5N160J-VqdzxnP9PURCWV5qbP53+d84p2Q0Q@mail.gmail.com>
From:   Alexander Holmes <chineduomor6@gmail.com>
Date:   Sat, 29 Aug 2020 15:50:38 +0200
Message-ID: <CAP2Ytbk2dkcXD_tRCKaiYgJZtH-V06QeKsj+Yo7HV0_cGAjT6g@mail.gmail.com>
Subject: : Hello My Dear how are you doing ?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Congratulations

This is MoneyGram International Inc. we are contacting you concerning
your winning fund $950,000.00 USD, your e-mail won $950,000.00 dollars
through Internet contest, lottery bonus under MoneyGram International
Inc. Worldwide. The lottery bonus was contesting once in a year and we
are doing it to promote this company MoneyGram International Inc. The
last contest was made through internet by people=E2=80=99s email worldwide,
for example. USA, CANADA, RUSSIA, EUROPE, ASIA, AFRICA, UNITED
KINGDOM, GERMANY, TOGO, SOUTH AFRICA, UAE, ETC

We are contacting you because you are among the winning people and
your winning code is [HJMR07378]. You are advice to contact our branch
office in Togo, West Africa. Through MoneyGram Email: (
moneygramdepromo@gmail.com ).
Agent Mr. Nelson Agboko. Phone: +228 79541985.

You will contact us with your info, such as below.
Surname ::::::::::::::::::
Middle name :::::::::::::::::::
Name :::::::::::::::::::
Home address :::::::::::::::::::::
Phone number ::::::::::::::::
Passport or ID card copy ::::::::::::::::::::

Regards
CEO: W. Alexander Holmes
MoneyGram International Inc.
Headquarters: Dallas, Texas, United States
