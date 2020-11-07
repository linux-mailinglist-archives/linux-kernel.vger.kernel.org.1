Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F242AA502
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 13:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgKGMbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 07:31:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:46909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbgKGMbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 07:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604752201;
        bh=pRkZCmbhMlo6oUutOkRwOUttqW+rH88och2cIIsSEwA=;
        h=X-UI-Sender-Class:From:Subject:Cc:To:Date;
        b=iEzUlor+HGaRgZQs8tUfysdDB5gihYoHSJMVekZsSJOvM4WDrdRnktHj+p/7fAHt7
         1oITZzMhM3B/QikalApf9fZ1bTxBD1y+OGW9ot8Neb4Qqx+XUpKj5WHyb46MtqEoQW
         iPuV8iRzxxhwRM7ZH2xbKoNjtmN26ihRfakz/qIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0oFz-1kNGkn1qOz-00woFK; Sat, 07
 Nov 2020 13:30:01 +0100
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: About the rockpi4 pcie controller failed to initialize problem in
 v5.10-rc2
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Cc:     matwey@sai.msu.ru
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <ca6213f8-8754-f77c-e1b3-10edccf2d81a@gmx.com>
Date:   Sat, 7 Nov 2020 20:29:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8ekXl7uxNyZASCUVheKrUCjcdJ5KiW73G"
X-Provags-ID: V03:K1:oDCsND/Iy8avICZxrBQWsQISn4go98gZ5EOF2jSuzZgwMnHKbJa
 LGi6/yXHdGe11JJnMxmFk5AWlGrrjLEk8wmPe6SnVg7IueXfGUT0pa9XuFBGalxy4R41Sv9
 wX0V4ZTjlUi8xmskoXg4B8yV8I/DlFvpYoFl2LQ1HhnaQe6kCqdwQTQ8SvDmha84PZUam54
 PWpNzBcQkeeRZWtS4xlMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QQz1Gnchj5I=:GH9Nn9CsLtlpVTb3BC18vt
 3JJRixaEdcUWz9tBmrdF935Sok75eXrFyrIIXqKkbAxkTWxCsbQ1XLYRWm3k82mWDY27LjPQa
 JsCqdlaACOCfTqoH1ArLUttEz6SiU9LWKaOewPOOhK5OaP47BqygB7EPk357m1SGsGWPYrATW
 0BDmW7ntmtjY04gRkjRfOWJA5cdMve9vcXvSUMXhcwBahk1d2AUQq7uCRPsXIC0RBAhVcFjaf
 lkhg2il+H93a5i92XP9OXTDm6sFLNhU40MO4Nd6Zg7QoGbJdcRbTBVdeQkf1it7lST3qpkMfR
 rIxKR5DYcLbwaZehh56olNgVXeRzQqvXw5ZKctMtaKPI54gvaEax/66hodCXomk/lD5VzRqw1
 +LuVD5stdsEmtSxrF3i/If+Q8AdRHM9LtA2MfoavxQezrWdNX6cNe2DGMGzr4QSKKNP8tAgXP
 orUGdjvXJ/8vgllfnFDWjVGJH4OgFcmb0lwlvSag6yvn84QSj4TWhkrOfxIEY8NzaYEDWTDhk
 q7K6kpZYmgMJp3gdIL2DSXd6eCAYXtmf1eIIV/LRPb06j/XQz8pYd8lhixcOMerQZqC+ZntUW
 hTz9Gw/sBnkCMZp8he/gqyHYZAQ/Mq1qcFxvwFCudXdk25yOkWni2Xxa5G/clnyLChOuqXZNK
 cw29fCa20+N6OYbwO8LATwJmQQyu5FE26osgzH2rA4W5O9DfWFfIFZHu9lmIlGMY5YJU3DuZ7
 crtEMN3NqzIaT5RvE3LUwk1z47O/TfsfUE81xqGneFU2T6hqzLqVTQVHp76XvMAESoQrAJITe
 ANzSSDcUNWGEcmm/KKOlygjpcZxcnjBMir7M3JraZfdDo6fGz7Ed/ONbahJM49XbFPnYnRdoF
 AGzVOaZUCIthCMKZmtZQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8ekXl7uxNyZASCUVheKrUCjcdJ5KiW73G
Content-Type: multipart/mixed; boundary="AAzmth3wDgIEE31mMxU4oqKVOZpNQ2Jbt"

--AAzmth3wDgIEE31mMxU4oqKVOZpNQ2Jbt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi guys,

I see your awesome contribution to support Rock Pi 4B.

However in recent rc (v5.10-rc2), I found that even with `vpcie1v8` and
`vpcie0v9` added, `regulartor_dev_lookup()` now just returns
-EPROBE_DEFER, preventing rockchip pcie controller to be initialized.

The full callchain is:

rockchip_pcie_parse_host_dt()
|- rockchip>vpcie1v8 =3D devm_regulator_get_optional(dev, "vpcie1v8");
   |- _regulator_get()
      |- regulator_dev_lookup()
         |- node =3D of_get_regulartor()
         |- if (!node) {
         |-     r =3D of_find_regulator(); /* No @r found */
         |-     return ERR_PTR(-EPROBE_DEFER);

This means we can't utilize PCIE controller completely.

But strangely, `vpcie12v` and `vpcie3v3` both initialized without problem=
=2E

Any clue on how the problem could happened? I guess it's some device
tree definition went crazy, but not familiar with device tree at all.

Thanks,
Qu


--AAzmth3wDgIEE31mMxU4oqKVOZpNQ2Jbt--

--8ekXl7uxNyZASCUVheKrUCjcdJ5KiW73G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+mkz8ACgkQwj2R86El
/qgQgwf9GqlZh0vsyNWmyX3VUSyOCbExsneFQ7VEZWKDYCi0TUPomvyV5FzWQLcd
CQXDL8M3/ts+Hy03KafVtrCw/GcNRx1x8d3GYFmrHGqL7EdC1TTMqgBlJbJhZMeN
UwYOm0UprzpvvaF5l1eupSto+t1fDIP5PjM5Wd+QXVD20nW3kp0ln3NQp/muLE/s
XqhbonDOY8hG99jnkWLP7SnIudrpMHr9d0L+Pnscnv6SQ4NDSmCvD7nHo5A1RXFx
5Pvj6yIQQXF8HQK/dOXTLnh7j+Ait1eDs/3SSj590nnVIxED4/2SaR4iXp9DjXyB
jzCCJ0wR3uNVXKRsY8UrCJuDJobs9A==
=wUxL
-----END PGP SIGNATURE-----

--8ekXl7uxNyZASCUVheKrUCjcdJ5KiW73G--
