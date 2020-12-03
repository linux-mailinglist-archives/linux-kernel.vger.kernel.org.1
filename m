Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF002CD329
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbgLCKGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:06:05 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19386 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388488AbgLCKGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:06:02 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B3A0Iuf029229;
        Thu, 3 Dec 2020 05:04:54 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vjen9mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 05:04:53 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0B3A4pal054407
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Dec 2020 05:04:52 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 3 Dec 2020
 02:04:50 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 3 Dec 2020 02:04:49 -0800
Received: from saturn.ad.analog.com ([10.48.65.108])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B3A4iAd003898;
        Thu, 3 Dec 2020 05:04:47 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 2/5] iio,counter: remove modes init for INDIO_DIRECT_MODE only drivers
Date:   Thu, 3 Dec 2020 12:04:20 +0200
Message-ID: <20201203100423.77270-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201203100423.77270-1-alexandru.ardelean@analog.com>
References: <20201203100423.77270-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_06:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the iio_device_alloc() call initializes the 'modes' of an IIO driver
to INDIO_DIRECT_MODE, this makes this boiler-plate code in all drivers that
explicitly init (and support) only this mode.

This change has been applied via this semantic patch:
// <smpl>
@exists@
expression indio_dev;
@@
  indio_dev = \(devm_iio_device_alloc\|iio_device_alloc\)(...)
  ...
- indio_dev->modes = INDIO_DIRECT_MODE;
// </smpl>

Only a few drivers are left after this patch has been applied.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/counter/104-quad-8.c                      | 1 -
 drivers/iio/accel/adis16201.c                     | 1 -
 drivers/iio/accel/adis16209.c                     | 1 -
 drivers/iio/accel/adxl345_core.c                  | 1 -
 drivers/iio/accel/bma180.c                        | 1 -
 drivers/iio/accel/bma220_spi.c                    | 1 -
 drivers/iio/accel/bma400_core.c                   | 1 -
 drivers/iio/accel/bmc150-accel-core.c             | 1 -
 drivers/iio/accel/da280.c                         | 1 -
 drivers/iio/accel/da311.c                         | 1 -
 drivers/iio/accel/dmard06.c                       | 1 -
 drivers/iio/accel/dmard09.c                       | 1 -
 drivers/iio/accel/dmard10.c                       | 1 -
 drivers/iio/accel/hid-sensor-accel-3d.c           | 1 -
 drivers/iio/accel/kxcjk-1013.c                    | 1 -
 drivers/iio/accel/kxsd9.c                         | 1 -
 drivers/iio/accel/mc3230.c                        | 1 -
 drivers/iio/accel/mma7455_core.c                  | 1 -
 drivers/iio/accel/mma7660.c                       | 1 -
 drivers/iio/accel/mma8452.c                       | 1 -
 drivers/iio/accel/mma9551.c                       | 1 -
 drivers/iio/accel/mma9553.c                       | 1 -
 drivers/iio/accel/mxc4005.c                       | 1 -
 drivers/iio/accel/mxc6255.c                       | 1 -
 drivers/iio/accel/sca3000.c                       | 1 -
 drivers/iio/accel/stk8312.c                       | 1 -
 drivers/iio/accel/stk8ba50.c                      | 1 -
 drivers/iio/adc/ab8500-gpadc.c                    | 1 -
 drivers/iio/adc/ad7091r-base.c                    | 1 -
 drivers/iio/adc/ad7124.c                          | 1 -
 drivers/iio/adc/ad7192.c                          | 1 -
 drivers/iio/adc/ad7266.c                          | 1 -
 drivers/iio/adc/ad7291.c                          | 1 -
 drivers/iio/adc/ad7292.c                          | 1 -
 drivers/iio/adc/ad7298.c                          | 1 -
 drivers/iio/adc/ad7476.c                          | 1 -
 drivers/iio/adc/ad7606.c                          | 1 -
 drivers/iio/adc/ad7766.c                          | 1 -
 drivers/iio/adc/ad7780.c                          | 1 -
 drivers/iio/adc/ad7791.c                          | 1 -
 drivers/iio/adc/ad7793.c                          | 1 -
 drivers/iio/adc/ad7887.c                          | 1 -
 drivers/iio/adc/ad7923.c                          | 1 -
 drivers/iio/adc/ad7949.c                          | 1 -
 drivers/iio/adc/ad799x.c                          | 1 -
 drivers/iio/adc/adi-axi-adc.c                     | 1 -
 drivers/iio/adc/aspeed_adc.c                      | 1 -
 drivers/iio/adc/at91_adc.c                        | 1 -
 drivers/iio/adc/axp20x_adc.c                      | 1 -
 drivers/iio/adc/axp288_adc.c                      | 1 -
 drivers/iio/adc/bcm_iproc_adc.c                   | 1 -
 drivers/iio/adc/berlin2-adc.c                     | 1 -
 drivers/iio/adc/cc10001_adc.c                     | 1 -
 drivers/iio/adc/da9150-gpadc.c                    | 1 -
 drivers/iio/adc/dln2-adc.c                        | 1 -
 drivers/iio/adc/ep93xx_adc.c                      | 1 -
 drivers/iio/adc/exynos_adc.c                      | 1 -
 drivers/iio/adc/hi8435.c                          | 1 -
 drivers/iio/adc/hx711.c                           | 1 -
 drivers/iio/adc/imx7d_adc.c                       | 1 -
 drivers/iio/adc/intel_mrfld_adc.c                 | 1 -
 drivers/iio/adc/lp8788_adc.c                      | 1 -
 drivers/iio/adc/lpc18xx_adc.c                     | 1 -
 drivers/iio/adc/lpc32xx_adc.c                     | 1 -
 drivers/iio/adc/ltc2471.c                         | 1 -
 drivers/iio/adc/ltc2485.c                         | 1 -
 drivers/iio/adc/max1027.c                         | 1 -
 drivers/iio/adc/max11100.c                        | 1 -
 drivers/iio/adc/max1118.c                         | 1 -
 drivers/iio/adc/max1241.c                         | 1 -
 drivers/iio/adc/max1363.c                         | 1 -
 drivers/iio/adc/max9611.c                         | 1 -
 drivers/iio/adc/mcp320x.c                         | 1 -
 drivers/iio/adc/mcp3422.c                         | 1 -
 drivers/iio/adc/mcp3911.c                         | 1 -
 drivers/iio/adc/men_z188_adc.c                    | 1 -
 drivers/iio/adc/meson_saradc.c                    | 1 -
 drivers/iio/adc/mp2629_adc.c                      | 1 -
 drivers/iio/adc/mt6360-adc.c                      | 1 -
 drivers/iio/adc/mt6577_auxadc.c                   | 1 -
 drivers/iio/adc/mxs-lradc-adc.c                   | 1 -
 drivers/iio/adc/nau7802.c                         | 1 -
 drivers/iio/adc/npcm_adc.c                        | 1 -
 drivers/iio/adc/palmas_gpadc.c                    | 1 -
 drivers/iio/adc/qcom-pm8xxx-xoadc.c               | 1 -
 drivers/iio/adc/qcom-spmi-adc5.c                  | 1 -
 drivers/iio/adc/qcom-spmi-iadc.c                  | 1 -
 drivers/iio/adc/qcom-spmi-vadc.c                  | 1 -
 drivers/iio/adc/rcar-gyroadc.c                    | 1 -
 drivers/iio/adc/rn5t618-adc.c                     | 1 -
 drivers/iio/adc/rockchip_saradc.c                 | 1 -
 drivers/iio/adc/sc27xx_adc.c                      | 1 -
 drivers/iio/adc/spear_adc.c                       | 1 -
 drivers/iio/adc/stm32-dfsdm-adc.c                 | 1 -
 drivers/iio/adc/stmpe-adc.c                       | 1 -
 drivers/iio/adc/stx104.c                          | 1 -
 drivers/iio/adc/sun4i-gpadc-iio.c                 | 1 -
 drivers/iio/adc/ti-adc081c.c                      | 1 -
 drivers/iio/adc/ti-adc0832.c                      | 1 -
 drivers/iio/adc/ti-adc084s021.c                   | 1 -
 drivers/iio/adc/ti-adc108s102.c                   | 1 -
 drivers/iio/adc/ti-adc12138.c                     | 1 -
 drivers/iio/adc/ti-adc128s052.c                   | 1 -
 drivers/iio/adc/ti-adc161s626.c                   | 1 -
 drivers/iio/adc/ti-ads1015.c                      | 1 -
 drivers/iio/adc/ti-ads124s08.c                    | 1 -
 drivers/iio/adc/ti-ads7950.c                      | 1 -
 drivers/iio/adc/ti-ads8344.c                      | 1 -
 drivers/iio/adc/ti-ads8688.c                      | 1 -
 drivers/iio/adc/ti-tlc4541.c                      | 1 -
 drivers/iio/adc/ti_am335x_adc.c                   | 1 -
 drivers/iio/adc/twl4030-madc.c                    | 1 -
 drivers/iio/adc/twl6030-gpadc.c                   | 1 -
 drivers/iio/adc/vf610_adc.c                       | 1 -
 drivers/iio/adc/viperboard_adc.c                  | 1 -
 drivers/iio/adc/xilinx-xadc-core.c                | 1 -
 drivers/iio/afe/iio-rescale.c                     | 1 -
 drivers/iio/amplifiers/ad8366.c                   | 1 -
 drivers/iio/amplifiers/hmc425a.c                  | 1 -
 drivers/iio/chemical/ams-iaq-core.c               | 1 -
 drivers/iio/chemical/atlas-ezo-sensor.c           | 1 -
 drivers/iio/chemical/bme680_core.c                | 1 -
 drivers/iio/chemical/ccs811.c                     | 1 -
 drivers/iio/chemical/pms7003.c                    | 1 -
 drivers/iio/chemical/scd30_core.c                 | 1 -
 drivers/iio/chemical/sgp30.c                      | 1 -
 drivers/iio/chemical/sps30.c                      | 1 -
 drivers/iio/chemical/vz89x.c                      | 1 -
 drivers/iio/dac/ad5064.c                          | 1 -
 drivers/iio/dac/ad5360.c                          | 1 -
 drivers/iio/dac/ad5380.c                          | 1 -
 drivers/iio/dac/ad5421.c                          | 1 -
 drivers/iio/dac/ad5446.c                          | 1 -
 drivers/iio/dac/ad5449.c                          | 1 -
 drivers/iio/dac/ad5504.c                          | 1 -
 drivers/iio/dac/ad5592r-base.c                    | 1 -
 drivers/iio/dac/ad5624r_spi.c                     | 1 -
 drivers/iio/dac/ad5686.c                          | 1 -
 drivers/iio/dac/ad5755.c                          | 1 -
 drivers/iio/dac/ad5758.c                          | 1 -
 drivers/iio/dac/ad5761.c                          | 1 -
 drivers/iio/dac/ad5764.c                          | 1 -
 drivers/iio/dac/ad5770r.c                         | 1 -
 drivers/iio/dac/ad5791.c                          | 1 -
 drivers/iio/dac/ad7303.c                          | 1 -
 drivers/iio/dac/ad8801.c                          | 1 -
 drivers/iio/dac/cio-dac.c                         | 1 -
 drivers/iio/dac/dpot-dac.c                        | 1 -
 drivers/iio/dac/ds4424.c                          | 1 -
 drivers/iio/dac/lpc18xx_dac.c                     | 1 -
 drivers/iio/dac/ltc1660.c                         | 1 -
 drivers/iio/dac/ltc2632.c                         | 1 -
 drivers/iio/dac/m62332.c                          | 1 -
 drivers/iio/dac/max517.c                          | 1 -
 drivers/iio/dac/max5821.c                         | 1 -
 drivers/iio/dac/mcp4725.c                         | 1 -
 drivers/iio/dac/mcp4922.c                         | 1 -
 drivers/iio/dac/stm32-dac.c                       | 1 -
 drivers/iio/dac/ti-dac082s085.c                   | 1 -
 drivers/iio/dac/ti-dac5571.c                      | 1 -
 drivers/iio/dac/ti-dac7311.c                      | 1 -
 drivers/iio/dac/ti-dac7612.c                      | 1 -
 drivers/iio/dac/vf610_dac.c                       | 1 -
 drivers/iio/dummy/iio_simple_dummy.c              | 3 ---
 drivers/iio/frequency/ad9523.c                    | 1 -
 drivers/iio/frequency/adf4350.c                   | 1 -
 drivers/iio/frequency/adf4371.c                   | 1 -
 drivers/iio/gyro/adis16080.c                      | 1 -
 drivers/iio/gyro/adis16130.c                      | 1 -
 drivers/iio/gyro/adis16136.c                      | 1 -
 drivers/iio/gyro/adis16260.c                      | 1 -
 drivers/iio/gyro/adxrs290.c                       | 1 -
 drivers/iio/gyro/adxrs450.c                       | 1 -
 drivers/iio/gyro/bmg160_core.c                    | 1 -
 drivers/iio/gyro/fxas21002c_core.c                | 1 -
 drivers/iio/gyro/hid-sensor-gyro-3d.c             | 1 -
 drivers/iio/gyro/itg3200_core.c                   | 1 -
 drivers/iio/gyro/mpu3050-core.c                   | 1 -
 drivers/iio/health/afe4403.c                      | 1 -
 drivers/iio/health/afe4404.c                      | 1 -
 drivers/iio/humidity/am2315.c                     | 1 -
 drivers/iio/humidity/dht11.c                      | 1 -
 drivers/iio/humidity/hdc100x.c                    | 1 -
 drivers/iio/humidity/hdc2010.c                    | 1 -
 drivers/iio/humidity/hid-sensor-humidity.c        | 1 -
 drivers/iio/humidity/hts221_core.c                | 1 -
 drivers/iio/humidity/htu21.c                      | 1 -
 drivers/iio/humidity/si7005.c                     | 1 -
 drivers/iio/humidity/si7020.c                     | 1 -
 drivers/iio/imu/adis16400.c                       | 1 -
 drivers/iio/imu/adis16460.c                       | 1 -
 drivers/iio/imu/adis16475.c                       | 1 -
 drivers/iio/imu/adis16480.c                       | 1 -
 drivers/iio/imu/bmi160/bmi160_core.c              | 1 -
 drivers/iio/imu/fxos8700_core.c                   | 1 -
 drivers/iio/imu/kmx61.c                           | 1 -
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c      | 1 -
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c      | 1 -
 drivers/iio/light/adjd_s311.c                     | 1 -
 drivers/iio/light/adux1020.c                      | 1 -
 drivers/iio/light/al3010.c                        | 1 -
 drivers/iio/light/al3320a.c                       | 1 -
 drivers/iio/light/apds9300.c                      | 1 -
 drivers/iio/light/as73211.c                       | 1 -
 drivers/iio/light/bh1750.c                        | 1 -
 drivers/iio/light/bh1780.c                        | 1 -
 drivers/iio/light/cm32181.c                       | 1 -
 drivers/iio/light/cm3232.c                        | 1 -
 drivers/iio/light/cm3323.c                        | 1 -
 drivers/iio/light/cm3605.c                        | 1 -
 drivers/iio/light/cm36651.c                       | 1 -
 drivers/iio/light/gp2ap002.c                      | 1 -
 drivers/iio/light/gp2ap020a00f.c                  | 1 -
 drivers/iio/light/hid-sensor-als.c                | 1 -
 drivers/iio/light/hid-sensor-prox.c               | 1 -
 drivers/iio/light/iqs621-als.c                    | 1 -
 drivers/iio/light/isl29018.c                      | 1 -
 drivers/iio/light/isl29028.c                      | 1 -
 drivers/iio/light/isl29125.c                      | 1 -
 drivers/iio/light/jsa1212.c                       | 1 -
 drivers/iio/light/lm3533-als.c                    | 1 -
 drivers/iio/light/ltr501.c                        | 1 -
 drivers/iio/light/lv0104cs.c                      | 1 -
 drivers/iio/light/max44009.c                      | 1 -
 drivers/iio/light/noa1305.c                       | 1 -
 drivers/iio/light/opt3001.c                       | 1 -
 drivers/iio/light/pa12203001.c                    | 1 -
 drivers/iio/light/rpr0521.c                       | 1 -
 drivers/iio/light/si1133.c                        | 1 -
 drivers/iio/light/si1145.c                        | 1 -
 drivers/iio/light/st_uvis25_core.c                | 1 -
 drivers/iio/light/stk3310.c                       | 1 -
 drivers/iio/light/tcs3414.c                       | 1 -
 drivers/iio/light/tcs3472.c                       | 1 -
 drivers/iio/light/tsl2563.c                       | 1 -
 drivers/iio/light/tsl2583.c                       | 1 -
 drivers/iio/light/tsl2772.c                       | 1 -
 drivers/iio/light/tsl4531.c                       | 1 -
 drivers/iio/light/us5182d.c                       | 1 -
 drivers/iio/light/vcnl4000.c                      | 1 -
 drivers/iio/light/vcnl4035.c                      | 1 -
 drivers/iio/light/veml6030.c                      | 1 -
 drivers/iio/light/veml6070.c                      | 1 -
 drivers/iio/light/vl6180.c                        | 1 -
 drivers/iio/light/zopt2201.c                      | 1 -
 drivers/iio/magnetometer/ak8974.c                 | 1 -
 drivers/iio/magnetometer/ak8975.c                 | 1 -
 drivers/iio/magnetometer/bmc150_magn.c            | 1 -
 drivers/iio/magnetometer/hid-sensor-magn-3d.c     | 1 -
 drivers/iio/magnetometer/hmc5843_core.c           | 1 -
 drivers/iio/magnetometer/mag3110.c                | 1 -
 drivers/iio/magnetometer/mmc35240.c               | 1 -
 drivers/iio/multiplexer/iio-mux.c                 | 1 -
 drivers/iio/orientation/hid-sensor-incl-3d.c      | 1 -
 drivers/iio/orientation/hid-sensor-rotation.c     | 1 -
 drivers/iio/position/iqs624-pos.c                 | 1 -
 drivers/iio/potentiometer/max5481.c               | 1 -
 drivers/iio/potentiometer/max5487.c               | 1 -
 drivers/iio/potentiostat/lmp91000.c               | 1 -
 drivers/iio/pressure/abp060mg.c                   | 1 -
 drivers/iio/pressure/bmp280-core.c                | 1 -
 drivers/iio/pressure/dlhl60d.c                    | 1 -
 drivers/iio/pressure/dps310.c                     | 1 -
 drivers/iio/pressure/hid-sensor-press.c           | 1 -
 drivers/iio/pressure/hp03.c                       | 1 -
 drivers/iio/pressure/hp206c.c                     | 1 -
 drivers/iio/pressure/icp10100.c                   | 1 -
 drivers/iio/pressure/mpl115.c                     | 1 -
 drivers/iio/pressure/mpl3115.c                    | 1 -
 drivers/iio/pressure/ms5637.c                     | 1 -
 drivers/iio/pressure/t5403.c                      | 1 -
 drivers/iio/pressure/zpa2326.c                    | 1 -
 drivers/iio/proximity/as3935.c                    | 1 -
 drivers/iio/proximity/isl29501.c                  | 1 -
 drivers/iio/proximity/mb1232.c                    | 1 -
 drivers/iio/proximity/ping.c                      | 1 -
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 -
 drivers/iio/proximity/rfd77402.c                  | 1 -
 drivers/iio/proximity/srf04.c                     | 1 -
 drivers/iio/proximity/srf08.c                     | 1 -
 drivers/iio/proximity/sx9310.c                    | 1 -
 drivers/iio/proximity/sx9500.c                    | 1 -
 drivers/iio/proximity/vcnl3020.c                  | 1 -
 drivers/iio/proximity/vl53l0x-i2c.c               | 1 -
 drivers/iio/resolver/ad2s1200.c                   | 1 -
 drivers/iio/resolver/ad2s90.c                     | 1 -
 drivers/iio/temperature/hid-sensor-temperature.c  | 1 -
 drivers/iio/temperature/iqs620at-temp.c           | 1 -
 drivers/iio/temperature/ltc2983.c                 | 1 -
 drivers/iio/temperature/max31856.c                | 1 -
 drivers/iio/temperature/maxim_thermocouple.c      | 1 -
 drivers/iio/temperature/mlx90614.c                | 1 -
 drivers/iio/temperature/mlx90632.c                | 1 -
 drivers/iio/temperature/tmp006.c                  | 1 -
 drivers/iio/temperature/tmp007.c                  | 1 -
 drivers/iio/temperature/tsys02d.c                 | 1 -
 drivers/input/touchscreen/tsc2007_iio.c           | 1 -
 drivers/platform/x86/toshiba_acpi.c               | 1 -
 drivers/staging/iio/accel/adis16203.c             | 1 -
 drivers/staging/iio/accel/adis16240.c             | 1 -
 drivers/staging/iio/adc/ad7280a.c                 | 1 -
 drivers/staging/iio/adc/ad7816.c                  | 1 -
 drivers/staging/iio/addac/adt7316.c               | 1 -
 drivers/staging/iio/cdc/ad7150.c                  | 2 --
 drivers/staging/iio/cdc/ad7746.c                  | 1 -
 drivers/staging/iio/frequency/ad9832.c            | 1 -
 drivers/staging/iio/frequency/ad9834.c            | 1 -
 drivers/staging/iio/resolver/ad2s1210.c           | 1 -
 308 files changed, 311 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 78766b6ec271..1cc23b3f4bf7 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1550,7 +1550,6 @@ static int quad8_probe(struct device *dev, unsigned int id)
 
 	/* Initialize IIO device */
 	indio_dev->info = &quad8_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
 	indio_dev->channels = quad8_channels;
 	indio_dev->name = dev_name(dev);
diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 3633a4e302c6..272e5a79d6f5 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -274,7 +274,6 @@ static int adis16201_probe(struct spi_device *spi)
 
 	indio_dev->channels = adis16201_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis_init(st, indio_dev, spi, &adis16201_data);
 	if (ret)
diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index 6c2d4a967de7..dcc581fdcef6 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -284,7 +284,6 @@ static int adis16209_probe(struct spi_device *spi)
 	indio_dev->info = &adis16209_info;
 	indio_dev->channels = adis16209_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis_init(st, indio_dev, spi, &adis16209_data);
 	if (ret)
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 312866530065..06854831d252 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -248,7 +248,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	indio_dev->name = name;
 	indio_dev->info = &adxl345_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 71f85a3e525b..78d795d272fb 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1040,7 +1040,6 @@ static int bma180_probe(struct i2c_client *client,
 	indio_dev->channels = data->part_info->channels;
 	indio_dev->num_channels = data->part_info->num_channels;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bma180_info;
 
 	if (client->irq > 0) {
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 3c9b0c6954e6..8b1d1dd1e678 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -249,7 +249,6 @@ static int bma220_probe(struct spi_device *spi)
 
 	indio_dev->info = &bma220_info;
 	indio_dev->name = BMA220_DEVICE_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = bma220_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
 	indio_dev->available_scan_masks = bma220_accel_scan_masks;
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 7eeba80e32cb..1812837883dd 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -820,7 +820,6 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
 	indio_dev->info = &bma400_info;
 	indio_dev->channels = bma400_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	dev_set_drvdata(dev, indio_dev);
 
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 7e425ebcd7ea..e5295bdd5e71 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1723,7 +1723,6 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	indio_dev->num_channels = data->chip_info->num_channels;
 	indio_dev->name = name ? name : data->chip_info->name;
 	indio_dev->available_scan_masks = bmc150_accel_scan_masks;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_accel_info;
 
 	if (block_supported) {
diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 4472dde6899e..bfb1eaba3a30 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -121,7 +121,6 @@ static int da280_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 
 	indio_dev->info = &da280_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = da280_channels;
 
 	if (ACPI_HANDLE(&client->dev)) {
diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 3b3df620ba27..4bf254a2d61d 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -233,7 +233,6 @@ static int da311_probe(struct i2c_client *client,
 
 	indio_dev->info = &da311_info;
 	indio_dev->name = "da311";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = da311_channels;
 	indio_dev->num_channels = ARRAY_SIZE(da311_channels);
 
diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index de2868c28d95..d9ab2d0c369c 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -162,7 +162,6 @@ static int dmard06_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->name = DMARD06_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = dmard06_channels;
 	indio_dev->num_channels = ARRAY_SIZE(dmard06_channels);
 	indio_dev->info = &dmard06_info;
diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index e6e28c964777..435da1ee574c 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -117,7 +117,6 @@ static int dmard09_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->name = DMARD09_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = dmard09_channels;
 	indio_dev->num_channels = ARRAY_SIZE(dmard09_channels);
 	indio_dev->info = &dmard09_info;
diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index 90206f015857..e7f13f8193a2 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -198,7 +198,6 @@ static int dmard10_probe(struct i2c_client *client,
 
 	indio_dev->info = &dmard10_info;
 	indio_dev->name = "dmard10";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = dmard10_channels;
 	indio_dev->num_channels = ARRAY_SIZE(dmard10_channels);
 
diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 4c5e594024f8..cd336081f6ab 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -386,7 +386,6 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 
 	indio_dev->info = &accel_3d_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&accel_state->common_attributes.data_ready, 0);
 
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index e92c7e6766e1..1ef27b889ef0 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1350,7 +1350,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(kxcjk1013_channels);
 	indio_dev->available_scan_masks = kxcjk1013_scan_masks;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &kxcjk1013_info;
 
 	if (client->irq > 0 && data->acpi_type != ACPI_SMO8500) {
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 0e18b92e2099..16983f73a5ad 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -416,7 +416,6 @@ int kxsd9_common_probe(struct device *dev,
 	indio_dev->num_channels = ARRAY_SIZE(kxsd9_channels);
 	indio_dev->name = name;
 	indio_dev->info = &kxsd9_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = kxsd9_scan_masks;
 
 	/* Read the mounting matrix, if present */
diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 46e4283fc037..359924dde4ab 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -134,7 +134,6 @@ static int mc3230_probe(struct i2c_client *client,
 
 	indio_dev->info = &mc3230_info;
 	indio_dev->name = "mc3230";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mc3230_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mc3230_channels);
 
diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index 922bd38ff6ea..9e965fa63424 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -268,7 +268,6 @@ int mma7455_core_probe(struct device *dev, struct regmap *regmap,
 
 	indio_dev->info = &mma7455_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mma7455_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mma7455_channels);
 	indio_dev->available_scan_masks = mma7455_scan_masks;
diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index b3c9136d51ec..1db557f575d6 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -190,7 +190,6 @@ static int mma7660_probe(struct i2c_client *client,
 
 	indio_dev->info = &mma7660_info;
 	indio_dev->name = MMA7660_DRIVER_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mma7660_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mma7660_channels);
 
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index b0176d936423..9983b03e2d00 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1589,7 +1589,6 @@ static int mma8452_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->info = &mma8452_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
 	indio_dev->available_scan_masks = mma8452_scan_masks;
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 08a2303cc9df..1751f57bc5ce 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -476,7 +476,6 @@ static int mma9551_probe(struct i2c_client *client,
 	indio_dev->channels = mma9551_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mma9551_channels);
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mma9551_info;
 
 	ret = mma9551_gpio_probe(indio_dev);
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index c15908faa381..b30d0aede74f 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1106,7 +1106,6 @@ static int mma9553_probe(struct i2c_client *client,
 	indio_dev->channels = mma9553_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mma9553_channels);
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mma9553_info;
 
 	if (client->irq > 0) {
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 0f8fd687866d..eb6eba58e3da 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -416,7 +416,6 @@ static int mxc4005_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(mxc4005_channels);
 	indio_dev->available_scan_masks = mxc4005_scan_masks;
 	indio_dev->name = MXC4005_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mxc4005_info;
 
 	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
index 9aeeadc420d3..c015d9b71596 100644
--- a/drivers/iio/accel/mxc6255.c
+++ b/drivers/iio/accel/mxc6255.c
@@ -140,7 +140,6 @@ static int mxc6255_probe(struct i2c_client *client,
 	indio_dev->name = MXC6255_DRV_NAME;
 	indio_dev->channels = mxc6255_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mxc6255_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mxc6255_info;
 
 	ret = regmap_read(data->regmap, MXC6255_REG_CHIP_ID, &chip_id);
diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 194738660523..2e8049eba102 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1477,7 +1477,6 @@ static int sca3000_probe(struct spi_device *spi)
 		indio_dev->channels = sca3000_channels;
 		indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
 	}
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = sca3000_configure_ring(indio_dev);
 	if (ret)
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 3b59887a8581..e11c2e899a52 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -515,7 +515,6 @@ static int stk8312_probe(struct i2c_client *client,
 
 	indio_dev->info = &stk8312_info;
 	indio_dev->name = STK8312_DRIVER_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = stk8312_channels;
 	indio_dev->num_channels = ARRAY_SIZE(stk8312_channels);
 
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 3ead378b02c9..bee01e7c7bd4 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -399,7 +399,6 @@ static int stk8ba50_probe(struct i2c_client *client,
 
 	indio_dev->info = &stk8ba50_info;
 	indio_dev->name = STK8BA50_DRIVER_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = stk8ba50_channels;
 	indio_dev->num_channels = ARRAY_SIZE(stk8ba50_channels);
 
diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 1bb987a4acba..2fe23e07142d 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -1164,7 +1164,6 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_put(dev);
 
 	indio_dev->name = "ab8500-gpadc";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ab8500_gpadc_info;
 	indio_dev->channels = iio_chans;
 	indio_dev->num_channels = n_iio_chans;
diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 63b4d6ea4566..d26fb6b3e87d 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -226,7 +226,6 @@ int ad7091r_probe(struct device *dev, const char *name,
 
 	iio_dev->name = name;
 	iio_dev->info = &ad7091r_info;
-	iio_dev->modes = INDIO_DIRECT_MODE;
 
 	iio_dev->num_channels = chip_info->num_channels;
 	iio_dev->channels = chip_info->channels;
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 766c73333604..aabca1fdfe70 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -731,7 +731,6 @@ static int ad7124_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = st->chip_info->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7124_info;
 
 	ret = ad7124_of_parse_channel_config(indio_dev, spi->dev.of_node);
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 2ed580521d81..1fd803f75d77 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -962,7 +962,6 @@ static int ad7192_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	st->chip_info = of_device_get_match_data(&spi->dev);
 	indio_dev->name = st->chip_info->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ad7192_channels_config(indio_dev);
 	if (ret < 0)
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index a8ec3efd659e..2e622254006f 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -436,7 +436,6 @@ static int ad7266_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7266_info;
 
 	ad7266_init_channels(indio_dev);
diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index 2301a0e27f23..abe2eea25905 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -503,7 +503,6 @@ static int ad7291_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ad7291_channels);
 
 	indio_dev->info = &ad7291_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ad7291_i2c_write(chip, AD7291_COMMAND, AD7291_RESET);
 	if (ret) {
diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index 70e33dd1c9f7..457a5b21fc31 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -303,7 +303,6 @@ static int ad7292_probe(struct spi_device *spi)
 	}
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7292_info;
 
 	for_each_available_child_of_node(spi->dev.of_node, child) {
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 689ecd5dd563..603e71b69b4e 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -323,7 +323,6 @@ static int ad7298_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad7298_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
 	indio_dev->info = &ad7298_info;
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 66c55ae67791..1ef4008b3a79 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -301,7 +301,6 @@ static int ad7476_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channel;
 	indio_dev->num_channels = 2;
 	indio_dev->info = &ad7476_info;
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ee7b108688b3..eaac9a98ac9c 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -624,7 +624,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		else
 			indio_dev->info = &ad7606_info_no_os_or_range;
 	}
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index b6b6765be7b4..a236d7df01bb 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -241,7 +241,6 @@ static int ad7766_probe(struct spi_device *spi)
 		return PTR_ERR(ad7766->pd_gpio);
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad7766_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7766_channels);
 	indio_dev->info = &ad7766_info;
diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index 42e7e8e595d1..7c18ae0e1c8d 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -321,7 +321,6 @@ static int ad7780_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 	indio_dev->info = &ad7780_info;
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index d57ad966e17c..85f2f1f99e87 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -426,7 +426,6 @@ static int ad7791_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
 	if (st->info->flags & AD7791_FLAG_HAS_FILTER)
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 5e980a06258e..b572c4195bc3 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -819,7 +819,6 @@ static int ad7793_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = st->chip_info->iio_info;
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 4f6f0e0e03ee..116e5e71894a 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -279,7 +279,6 @@ static int ad7887_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad7887_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default message */
 
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index a2cc96658054..1cbd2130ae33 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -315,7 +315,6 @@ static int ad7923_probe(struct spi_device *spi)
 	info = &ad7923_chip_info[spi_get_device_id(spi)->driver_data];
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = info->channels;
 	indio_dev->num_channels = info->num_channels;
 	indio_dev->info = &ad7923_info;
diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 5d597e5050f6..cef45bbfe676 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -245,7 +245,6 @@ static int ad7949_spi_probe(struct spi_device *spi)
 
 	indio_dev->info = &ad7949_spi_info;
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad7949_adc_channels;
 	spi_set_drvdata(spi, indio_dev);
 
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 1575b7670207..6d934984eabf 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -817,7 +817,6 @@ static int ad799x_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->info = st->chip_config->info;
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_config->channel;
 	indio_dev->num_channels = chip_info->num_channels;
 
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 9109da2d2e15..270cf2b31fc1 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -436,7 +436,6 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 
 	indio_dev->info = &adi_axi_adc_info;
 	indio_dev->name = "adi-axi-adc";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = conv->chip_info->num_channels;
 	indio_dev->channels = conv->chip_info->channels;
 
diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 19efaa41bc34..da7640c4bd27 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -253,7 +253,6 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	model_data = of_device_get_match_data(&pdev->dev);
 	indio_dev->name = model_data->model_name;
 	indio_dev->info = &aspeed_adc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = aspeed_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(aspeed_adc_iio_channels);
 
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 70750abb5dea..26a90f8cbf0c 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1058,7 +1058,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, idev);
 
 	idev->name = dev_name(&pdev->dev);
-	idev->modes = INDIO_DIRECT_MODE;
 	idev->info = &at91_adc_info;
 
 	st->irq = platform_get_irq(pdev, 0);
diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 3e0c0233b431..564c1ef27a9a 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -668,7 +668,6 @@ static int axp20x_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 
 	info->regmap = axp20x_dev->regmap;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (!dev_fwnode(&pdev->dev)) {
 		const struct platform_device_id *id;
diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 5f5e8b39e4d2..d8525cf84be4 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -275,7 +275,6 @@ static int axp288_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = axp288_adc_channels;
 	indio_dev->num_channels = ARRAY_SIZE(axp288_adc_channels);
 	indio_dev->info = &axp288_adc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	ret = iio_map_array_register(indio_dev, axp288_adc_default_maps);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 44e1e53ada72..a2722809c92b 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -574,7 +574,6 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	indio_dev->name = "iproc-static-adc";
 	indio_dev->info = &iproc_adc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = iproc_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(iproc_adc_iio_channels);
 
diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 8b04b95b7b7a..12fb0e2f3350 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -322,7 +322,6 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 	mutex_init(&priv->lock);
 
 	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &berlin2_adc_info;
 
 	indio_dev->channels = berlin2_adc_channels;
diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index e16ac935693b..dd5fc5be459f 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -336,7 +336,6 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &cc10001_adc_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	adc_dev->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(adc_dev->reg_base)) {
diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
index 7a7a54a7ed76..9d144c4b8e23 100644
--- a/drivers/iio/adc/da9150-gpadc.c
+++ b/drivers/iio/adc/da9150-gpadc.c
@@ -355,7 +355,6 @@ static int da9150_gpadc_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &da9150_gpadc_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = da9150_gpadc_channels;
 	indio_dev->num_channels = ARRAY_SIZE(da9150_gpadc_channels);
 
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 0d53ef18e045..2147f26aa246 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -643,7 +643,6 @@ static int dln2_adc_probe(struct platform_device *pdev)
 
 	indio_dev->name = DLN2_ADC_MOD_NAME;
 	indio_dev->info = &dln2_adc_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = dln2->iio_channels;
 	indio_dev->num_channels = chans + 1;
 	indio_dev->setup_ops = &dln2_adc_buffer_setup_ops;
diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index c08ab3c6dfaf..d7a3313cd5ed 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -171,7 +171,6 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
 	}
 
 	iiodev->name = dev_name(&pdev->dev);
-	iiodev->modes = INDIO_DIRECT_MODE;
 	iiodev->info = &ep93xx_adc_info;
 	iiodev->num_channels = ARRAY_SIZE(ep93xx_adc_channels);
 	iiodev->channels = ep93xx_adc_channels;
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 784c10deeb1a..7da638b5c59a 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -879,7 +879,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &exynos_adc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = exynos_adc_iio_channels;
 	indio_dev->num_channels = info->data->num_channels;
 
diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 074c30970465..fc549187a11f 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -487,7 +487,6 @@ static int hi8435_probe(struct spi_device *spi)
 	mutex_init(&priv->lock);
 
 	idev->name		= spi_get_device_id(spi)->name;
-	idev->modes		= INDIO_DIRECT_MODE;
 	idev->info		= &hi8435_info;
 	idev->channels		= hi8435_channels;
 	idev->num_channels	= ARRAY_SIZE(hi8435_channels);
diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 6a173531d355..5de1da7bd46c 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -552,7 +552,6 @@ static int hx711_probe(struct platform_device *pdev)
 
 	indio_dev->name = "hx711";
 	indio_dev->info = &hx711_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = hx711_chan_spec;
 	indio_dev->num_channels = ARRAY_SIZE(hx711_chan_spec);
 
diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 4969a5f941e3..2f0aeedc7186 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -516,7 +516,6 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &imx7d_adc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = imx7d_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(imx7d_adc_iio_channels);
 
diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
index 75394350eb4c..8c69ae109f87 100644
--- a/drivers/iio/adc/intel_mrfld_adc.c
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -212,7 +212,6 @@ static int mrfld_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = mrfld_adc_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mrfld_adc_channels);
 	indio_dev->info = &mrfld_adc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_map_array_register(indio_dev, iio_maps);
 	if (ret)
diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index 8fb57e375529..26d54e28cabe 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -205,7 +205,6 @@ static int lp8788_adc_probe(struct platform_device *pdev)
 	mutex_init(&adc->lock);
 
 	indio_dev->name = pdev->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &lp8788_adc_info;
 	indio_dev->channels = lp8788_adc_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lp8788_adc_channels);
diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index 3566990ae87d..ba7a6bcd5194 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -153,7 +153,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &lpc18xx_adc_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = lpc18xx_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lpc18xx_adc_iio_channels);
 
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index b56ce15255cf..c56b80b03e32 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -198,7 +198,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 
 	iodev->name = LPC32XXAD_NAME;
 	iodev->info = &lpc32xx_adc_iio_info;
-	iodev->modes = INDIO_DIRECT_MODE;
 	iodev->num_channels = ARRAY_SIZE(lpc32xx_adc_iio_channels);
 
 	retval = devm_iio_device_register(&pdev->dev, iodev);
diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index 0e0fe881a8e6..b7daf5631626 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -118,7 +118,6 @@ static int ltc2471_i2c_probe(struct i2c_client *client,
 
 	indio_dev->name = id->name;
 	indio_dev->info = &ltc2471_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	if (id->driver_data == ltc2473)
 		indio_dev->channels = ltc2473_channel;
 	else
diff --git a/drivers/iio/adc/ltc2485.c b/drivers/iio/adc/ltc2485.c
index 37c762f8218c..4f13f66678e9 100644
--- a/drivers/iio/adc/ltc2485.c
+++ b/drivers/iio/adc/ltc2485.c
@@ -110,7 +110,6 @@ static int ltc2485_probe(struct i2c_client *client,
 
 	indio_dev->name = id->name;
 	indio_dev->info = &ltc2485_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ltc2485_channel;
 	indio_dev->num_channels = ARRAY_SIZE(ltc2485_channel);
 
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index ca1dff3924ff..6cf23835ed32 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -440,7 +440,6 @@ static int max1027_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &max1027_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
 	indio_dev->available_scan_masks = st->info->available_scan_masks;
diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index 6cf21758ca66..1aabc7b2e0f6 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -118,7 +118,6 @@ static int max11100_probe(struct spi_device *spi)
 
 	indio_dev->name = "max11100";
 	indio_dev->info = &max11100_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = max11100_channels;
 	indio_dev->num_channels = ARRAY_SIZE(max11100_channels);
 
diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 6efb0b43d938..a3cfc9614591 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -231,7 +231,6 @@ static int max1118_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &max1118_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = max1118_channels;
 	indio_dev->num_channels = ARRAY_SIZE(max1118_channels);
 
diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
index 0cbbb3c56d08..b81be7a00870 100644
--- a/drivers/iio/adc/max1241.c
+++ b/drivers/iio/adc/max1241.c
@@ -193,7 +193,6 @@ static int max1241_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &max1241_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = max1241_channels;
 	indio_dev->num_channels = ARRAY_SIZE(max1241_channels);
 
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index f2b576c69949..bbafef992a74 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1652,7 +1652,6 @@ static int max1363_probe(struct i2c_client *client,
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = st->chip_info->info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	ret = max1363_initial_setup(st);
 	if (ret < 0)
 		goto error_disable_reg;
diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 052ab23f10b2..0e7b626e2edc 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -546,7 +546,6 @@ static int max9611_probe(struct i2c_client *client,
 		return ret;
 
 	indio_dev->name		= of_id->data;
-	indio_dev->modes	= INDIO_DIRECT_MODE;
 	indio_dev->info		= &indio_info;
 	indio_dev->channels	= max9611_channels;
 	indio_dev->num_channels	= ARRAY_SIZE(max9611_channels);
diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 8d1cff28cae0..ba183810abae 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -386,7 +386,6 @@ static int mcp320x_probe(struct spi_device *spi)
 	adc->spi = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp320x_info;
 	spi_set_drvdata(spi, indio_dev);
 
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index da353dcb1e9d..7f6721517963 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -352,7 +352,6 @@ static int mcp3422_probe(struct i2c_client *client,
 	mutex_init(&adc->lock);
 
 	indio_dev->name = dev_name(&client->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp3422_info;
 
 	switch (adc->id) {
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index e573da5397bb..6edde8674291 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -294,7 +294,6 @@ static int mcp3911_probe(struct spi_device *spi)
 		goto clk_disable;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp3911_info;
 	spi_set_drvdata(spi, indio_dev);
 
diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index 42ea8bc7e780..9316f8b254dc 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -111,7 +111,6 @@ static int men_z188_probe(struct mcb_device *dev,
 	adc = iio_priv(indio_dev);
 	indio_dev->name = "z188-adc";
 	indio_dev->info = &z188_adc_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = z188_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(z188_adc_iio_channels);
 
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 66dc452d643a..bf84b74d4c6e 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1200,7 +1200,6 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	priv->param = match_data->param;
 
 	indio_dev->name = match_data->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &meson_sar_adc_iio_info;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 331a9a728217..f776d277af7c 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -147,7 +147,6 @@ static int mp2629_adc_probe(struct platform_device *pdev)
 	indio_dev->dev.parent = dev;
 	indio_dev->channels = mp2629_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mp2629_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mp2629_adc_info;
 
 	ret = iio_device_register(indio_dev);
diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index f57db3056fbe..6d914878b018 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -338,7 +338,6 @@ static int mt6360_adc_probe(struct platform_device *pdev)
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &mt6360_adc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mt6360_adc_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mt6360_adc_channels);
 
diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 79c1dd68b909..5a569f938fb0 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -247,7 +247,6 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 	adc_dev = iio_priv(indio_dev);
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &mt6577_auxadc_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mt6577_auxadc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mt6577_auxadc_iio_channels);
 
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 30e29f44ebd2..9aba3bf6f8b3 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -722,7 +722,6 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	iio->name = pdev->name;
 	iio->dev.of_node = dev->parent->of_node;
 	iio->info = &mxs_lradc_adc_iio_info;
-	iio->modes = INDIO_DIRECT_MODE;
 	iio->masklength = LRADC_MAX_TOTAL_CHANS;
 
 	if (lradc->soc == IMX23_LRADC) {
diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 07c85434b568..5ac3debd0f0f 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -431,7 +431,6 @@ static int nau7802_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 
 	indio_dev->name = dev_name(&client->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &nau7802_info;
 
 	st->client = client;
diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index d9d105920001..cdb32402577f 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -262,7 +262,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &npcm_adc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = npcm_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(npcm_adc_iio_channels);
 
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 889b88768b63..18580ce1463a 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -593,7 +593,6 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 
 	indio_dev->name = MOD_NAME;
 	indio_dev->info = &palmas_gpadc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = palmas_gpadc_iio_channel;
 	indio_dev->num_channels = ARRAY_SIZE(palmas_gpadc_iio_channel);
 
diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 7e108da7d255..d75c0f6d57f9 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -935,7 +935,6 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 	}
 
 	indio_dev->name = variant->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &pm8xxx_xoadc_info;
 	indio_dev->channels = adc->iio_chans;
 	indio_dev->num_channels = adc->nchans;
diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index c10aa28be70a..bb6aec0b24b6 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -972,7 +972,6 @@ static int adc5_probe(struct platform_device *pdev)
 	}
 
 	indio_dev->name = pdev->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = adc->data->info;
 	indio_dev->channels = adc->iio_chans;
 	indio_dev->num_channels = adc->nchannels;
diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index acbda6636dc5..8cea9583e865 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -554,7 +554,6 @@ static int iadc_probe(struct platform_device *pdev)
 	}
 
 	indio_dev->name = pdev->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &iadc_info;
 	indio_dev->channels = iadc_channels;
 	indio_dev->num_channels = ARRAY_SIZE(iadc_channels);
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index b0388f8a69f4..0de003bd804a 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -908,7 +908,6 @@ static int vadc_probe(struct platform_device *pdev)
 		return ret;
 
 	indio_dev->name = pdev->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &vadc_info;
 	indio_dev->channels = vadc->iio_chans;
 	indio_dev->num_channels = vadc->nchannels;
diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 9f38cf3c7dc2..91991321e118 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -523,7 +523,6 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 
 	indio_dev->name = DRIVER_NAME;
 	indio_dev->info = &rcar_gyroadc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret) {
diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index 7010c4276947..b2daa35e7bd9 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -219,7 +219,6 @@ static int rn5t618_adc_probe(struct platform_device *pdev)
 
 	iio_dev->name = dev_name(&pdev->dev);
 	iio_dev->info = &rn5t618_adc_iio_info;
-	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->channels = rn5t618_adc_iio_channels;
 	iio_dev->num_channels = ARRAY_SIZE(rn5t618_adc_iio_channels);
 
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 1f3d7d639d37..69c21c539a8b 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -420,7 +420,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &rockchip_saradc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->channels = info->data->channels;
 	indio_dev->num_channels = info->data->num_channels;
diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index aa32a1f385e2..67dc7cf4bde5 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -534,7 +534,6 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	}
 
 	indio_dev->name = dev_name(dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &sc27xx_info;
 	indio_dev->channels = sc27xx_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 1bc986a7009d..1a00a397bd4f 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -337,7 +337,6 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	indio_dev->name = SPEAR_ADC_MOD_NAME;
 	indio_dev->info = &spear_adc_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = spear_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(spear_adc_iio_channels);
 
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 9234f14167b7..c36c55fdd7b7 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1543,7 +1543,6 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	adc->dfsdm = dev_get_drvdata(dev->parent);
 
 	iio->dev.of_node = np;
-	iio->modes = INDIO_DIRECT_MODE;
 
 	platform_set_drvdata(pdev, iio);
 
diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index fba659bfdb40..410d2089fdec 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -298,7 +298,6 @@ static int stmpe_adc_probe(struct platform_device *pdev)
 
 	indio_dev->name		= dev_name(&pdev->dev);
 	indio_dev->info		= &stmpe_adc_iio_info;
-	indio_dev->modes	= INDIO_DIRECT_MODE;
 
 	info->stmpe = dev_get_drvdata(pdev->dev.parent);
 
diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 55bd2dc514e9..0b07c11352ed 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -307,7 +307,6 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	}
 
 	indio_dev->info = &stx104_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* determine if differential inputs */
 	if (inb(base[id] + 8) & BIT(5)) {
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 99b43f28e879..5377a52ca0fe 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -620,7 +620,6 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	init_completion(&info->completion);
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &sun4i_gpadc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (pdev->dev.of_node)
 		ret = sun4i_gpadc_probe_dt(pdev, indio_dev);
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index b64718daa201..1f0f8252def3 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -176,7 +176,6 @@ static int adc081c_probe(struct i2c_client *client,
 		return err;
 
 	iio->name = dev_name(&client->dev);
-	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &adc081c_info;
 
 	iio->channels = model->channels;
diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index 0261b3cfc92b..74e3eb67ce24 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -252,7 +252,6 @@ static int adc0832_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &adc0832_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	switch (spi_get_device_id(spi)->driver_data) {
 	case adc0831:
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index fb14b92fa6e7..c49ec5171bb7 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -215,7 +215,6 @@ static int adc084s021_probe(struct spi_device *spi)
 
 	/* Initiate the Industrial I/O device */
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &adc084s021_info;
 	indio_dev->channels = adc084s021_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adc084s021_channels);
diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 183b2245e89b..54f3feac6ba9 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -253,7 +253,6 @@ static int adc108s102_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->name = spi->modalias;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adc108s102_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adc108s102_channels);
 	indio_dev->info = &adc108s102_info;
diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index fcd5d39dd03e..2903f5c5ef08 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -413,7 +413,6 @@ static int adc12138_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &adc12138_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	switch (adc->id) {
 	case adc12130:
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 3143f35a6509..dab89ca33479 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -154,7 +154,6 @@ static int adc128_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &adc128_info;
 
 	indio_dev->channels = adc128_config[config].channels;
diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 607791ffe7f0..f3c224fd781e 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -181,7 +181,6 @@ static int ti_adc_probe(struct spi_device *spi)
 
 	indio_dev->info = &ti_adc_info;
 	indio_dev->name = TI_ADC_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	spi_set_drvdata(spi, indio_dev);
 
 	data = iio_priv(indio_dev);
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9fef39bcf997..42b2511b099f 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -948,7 +948,6 @@ static int ads1015_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 
 	indio_dev->name = ADS1015_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	chip = (enum chip_ids)device_get_match_data(&client->dev);
 	if (chip == ADSXXXX)
diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index b4a128b19188..990d8ca63ffc 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -332,7 +332,6 @@ static int ads124s_probe(struct spi_device *spi)
 	ads124s_priv->spi = spi;
 
 	indio_dev->name = spi_id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ads124s_priv->chip_info->channels;
 	indio_dev->num_channels = ads124s_priv->chip_info->num_channels;
 	indio_dev->info = &ads124s_info;
diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 2383eacada87..53d0a773c934 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -557,7 +557,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	info = &ti_ads7950_chip_info[spi_get_device_id(spi)->driver_data];
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = info->channels;
 	indio_dev->num_channels = info->num_channels;
 	indio_dev->info = &ti_ads7950_info;
diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
index a345a30d74fa..2e2fb1ba0b0f 100644
--- a/drivers/iio/adc/ti-ads8344.c
+++ b/drivers/iio/adc/ti-ads8344.c
@@ -149,7 +149,6 @@ static int ads8344_probe(struct spi_device *spi)
 
 	indio_dev->name = dev_name(&spi->dev);
 	indio_dev->info = &ads8344_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ads8344_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ads8344_channels);
 
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 16bcb37eebb7..6adad281f13d 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -449,7 +449,6 @@ static int ads8688_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = &ads8688_info;
diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
index 403b787f9f7e..ad7032d3e7f7 100644
--- a/drivers/iio/adc/ti-tlc4541.c
+++ b/drivers/iio/adc/ti-tlc4541.c
@@ -178,7 +178,6 @@ static int tlc4541_probe(struct spi_device *spi)
 	info = &tlc4541_chip_info[spi_get_device_id(spi)->driver_data];
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = info->channels;
 	indio_dev->num_channels = info->num_channels;
 	indio_dev->info = &tlc4541_info;
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index e946903b0993..75918265eff1 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -612,7 +612,6 @@ static int tiadc_probe(struct platform_device *pdev)
 	tiadc_parse_dt(pdev, adc_dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &tiadc_info;
 
 	tiadc_step_config(indio_dev);
diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 6ce40cc4568a..fb4df2f833e4 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -773,7 +773,6 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 
 	iio_dev->name = dev_name(&pdev->dev);
 	iio_dev->info = &twl4030_madc_iio_info;
-	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->channels = twl4030_madc_iio_channels;
 	iio_dev->num_channels = ARRAY_SIZE(twl4030_madc_iio_channels);
 
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index c6416ad795ca..58c1ac292d1c 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -927,7 +927,6 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 
 	indio_dev->name = DRIVER_NAME;
 	indio_dev->info = &twl6030_gpadc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = pdata->iio_channels;
 	indio_dev->num_channels = pdata->nchannels;
 
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 1d794cf3e3f1..d9d2a1e1f3d3 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -856,7 +856,6 @@ static int vf610_adc_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &vf610_adc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = vf610_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
 
diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 1028b101cf56..24e37fe6e558 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -122,7 +122,6 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
 	adc->vb = vb;
 	indio_dev->name = "viperboard adc";
 	indio_dev->info = &vprbrd_adc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = vprbrd_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vprbrd_adc_iio_channels);
 
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index f93c34fe5873..ea2f93ea8224 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1223,7 +1223,6 @@ static int xadc_probe(struct platform_device *pdev)
 		return PTR_ERR(xadc->base);
 
 	indio_dev->name = "xadc";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &xadc_info;
 
 	ret = xadc_parse_dt(indio_dev, pdev->dev.of_node, &conf0);
diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e42ea2b1707d..c13a78c2c280 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -313,7 +313,6 @@ static int rescale_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &rescale_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &rescale->chan;
 	indio_dev->num_channels = 1;
 	if (sizeof_ext_info) {
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index cfcf18a0bce8..458557f04ad2 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -279,7 +279,6 @@ static int ad8366_probe(struct spi_device *spi)
 	st->info = &ad8366_infos[st->type];
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad8366_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ad8366_write(indio_dev, 0 , 0);
 	if (ret < 0)
diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 9efa692151f0..ad0a9c1bb6ea 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -225,7 +225,6 @@ static int hmc425a_probe(struct platform_device *pdev)
 	mutex_init(&st->lock);
 
 	indio_dev->info = &hmc425a_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index 97be3669c554..671909879825 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -155,7 +155,6 @@ static int ams_iaqcore_probe(struct i2c_client *client,
 
 	indio_dev->info = &ams_iaqcore_info;
 	indio_dev->name = dev_name(&client->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->channels = ams_iaqcore_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ams_iaqcore_channels);
diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index b1bacfe3c3ce..f0b9aaf52ec7 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -221,7 +221,6 @@ static int atlas_ezo_probe(struct i2c_client *client,
 	indio_dev->name = ATLAS_EZO_DRV_NAME;
 	indio_dev->channels = chip->channels;
 	indio_dev->num_channels = chip->num_channels;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	data = iio_priv(indio_dev);
 	data->client = client;
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 6ea99e4cbf92..75f579598a47 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -927,7 +927,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->channels = bme680_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bme680_channels);
 	indio_dev->info = &bme680_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* default values for the sensor */
 	data->oversampling_humid = 2; /* 2X oversampling rate */
diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 60dd87e96f5f..16fa3908e084 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -471,7 +471,6 @@ static int ccs811_probe(struct i2c_client *client,
 
 	indio_dev->name = id->name;
 	indio_dev->info = &ccs811_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->channels = ccs811_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ccs811_channels);
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index e9d4405654bc..8d51e12d2021 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -284,7 +284,6 @@ static int pms7003_probe(struct serdev_device *serdev)
 	indio_dev->name = PMS7003_DRIVER_NAME;
 	indio_dev->channels = pms7003_channels,
 	indio_dev->num_channels = ARRAY_SIZE(pms7003_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = pms7003_scan_masks;
 
 	mutex_init(&state->lock);
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 4d0d798c7cd3..3c3ade509314 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -701,7 +701,6 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 	indio_dev->name = name;
 	indio_dev->channels = scd30_channels;
 	indio_dev->num_channels = ARRAY_SIZE(scd30_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = scd30_scan_masks;
 
 	state->vdd = devm_regulator_get(dev, "vdd");
diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index 1029c457be15..095a57df7c9a 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -534,7 +534,6 @@ static int sgp_probe(struct i2c_client *client,
 
 	indio_dev->info = &sgp_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = sgp_devices[product_id].channels;
 	indio_dev->num_channels = sgp_devices[product_id].num_channels;
 
diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 2ea9a5c4d846..e7ea71228bff 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -491,7 +491,6 @@ static int sps30_probe(struct i2c_client *client)
 	indio_dev->name = client->name;
 	indio_dev->channels = sps30_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sps30_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = sps30_scan_masks;
 
 	mutex_init(&state->lock);
diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 23b22a5f5c1c..268a8c2dc16b 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -382,7 +382,6 @@ static int vz89x_probe(struct i2c_client *client,
 
 	indio_dev->info = &vz89x_info;
 	indio_dev->name = dev_name(dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->channels = data->chip->channels;
 	indio_dev->num_channels = data->chip->num_channels;
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 82abd4d6886c..b4d4c4c13f2b 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -876,7 +876,6 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 
 	indio_dev->name = name;
 	indio_dev->info = &ad5064_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 602dd2ba61b5..1b0caa8a5d7a 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -478,7 +478,6 @@ static int ad5360_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5360_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
 	mutex_init(&st->lock);
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 37ef653564b0..39887cc10291 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -388,7 +388,6 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 
 	indio_dev->name = name;
 	indio_dev->info = &ad5380_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
 	mutex_init(&st->lock);
diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index eedf661d32b2..bb68f3df0586 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -489,7 +489,6 @@ static int ad5421_probe(struct spi_device *spi)
 
 	indio_dev->name = "ad5421";
 	indio_dev->info = &ad5421_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad5421_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5421_channels);
 
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index d87e21016863..c63f50a0aeec 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -256,7 +256,6 @@ static int ad5446_probe(struct device *dev, const char *name,
 
 	indio_dev->name = name;
 	indio_dev->info = &ad5446_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 
diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index f5e93c6acc9d..03bd8e5035e5 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -299,7 +299,6 @@ static int ad5449_spi_probe(struct spi_device *spi)
 
 	indio_dev->name = id->name;
 	indio_dev->info = &ad5449_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 28921b62e642..77cc4165c1c8 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -310,7 +310,6 @@ static int ad5504_probe(struct spi_device *spi)
 	else
 		indio_dev->num_channels = 4;
 	indio_dev->channels = ad5504_channels;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (spi->irq) {
 		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 0405e92b9e8c..c9afa15daf24 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -616,7 +616,6 @@ int ad5592r_probe(struct device *dev, const char *name,
 
 	iio_dev->name = name;
 	iio_dev->info = &ad5592r_info;
-	iio_dev->modes = INDIO_DIRECT_MODE;
 
 	mutex_init(&st->lock);
 
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index 2b2b8edfd258..785662fa6e16 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -255,7 +255,6 @@ static int ad5624r_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5624r_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = AD5624R_DAC_CHANNELS;
 
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 7d6792ac1020..e803945053cf 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -476,7 +476,6 @@ int ad5686_probe(struct device *dev,
 
 	indio_dev->name = name;
 	indio_dev->info = &ad5686_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 0df28acf074a..c1963ccba45e 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -746,7 +746,6 @@ static int ad5755_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5755_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = AD5755_NUM_CHANNELS;
 
 	mutex_init(&st->lock);
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index bd9ac8359d98..367c11545e6b 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -856,7 +856,6 @@ static int ad5758_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5758_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = 1;
 
 	ret = ad5758_parse_dt(st);
diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
index e37e095e94fc..16924535f507 100644
--- a/drivers/iio/dac/ad5761.c
+++ b/drivers/iio/dac/ad5761.c
@@ -377,7 +377,6 @@ static int ad5761_probe(struct spi_device *spi)
 		goto disable_regulator_err;
 
 	iio_dev->info = &ad5761_info;
-	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->channels = &chip_info->channel;
 	iio_dev->num_channels = 1;
 	iio_dev->name = spi_get_device_id(st->spi)->name;
diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index ae089b9145cb..278161e15330 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -291,7 +291,6 @@ static int ad5764_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5764_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = AD5764_NUM_CHANNELS;
 	indio_dev->channels = st->chip_info->channels;
 
diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index 84dcf149261f..a0dd3ab109a0 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -653,7 +653,6 @@ static int ad5770r_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5770r_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad5770r_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5770r_channels);
 
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index e3ffa4b9f84c..af078d1dda14 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -408,7 +408,6 @@ static int ad5791_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, indio_dev);
 	indio_dev->info = &ad5791_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels
 		= &ad5791_channels[spi_get_device_id(spi)->driver_data];
 	indio_dev->num_channels = 1;
diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index dbb4645ab6b1..440d30740ccb 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -242,7 +242,6 @@ static int ad7303_probe(struct spi_device *spi)
 
 	indio_dev->name = id->name;
 	indio_dev->info = &ad7303_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad7303_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7303_channels);
 
diff --git a/drivers/iio/dac/ad8801.c b/drivers/iio/dac/ad8801.c
index 6354b7c8f052..bb4e077d940f 100644
--- a/drivers/iio/dac/ad8801.c
+++ b/drivers/iio/dac/ad8801.c
@@ -172,7 +172,6 @@ static int ad8801_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, indio_dev);
 	indio_dev->info = &ad8801_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad8801_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad8801_channels);
 	indio_dev->name = id->name;
diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
index 95813569f394..e5fb91372e42 100644
--- a/drivers/iio/dac/cio-dac.c
+++ b/drivers/iio/dac/cio-dac.c
@@ -106,7 +106,6 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
 	}
 
 	indio_dev->info = &cio_dac_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = cio_dac_channels;
 	indio_dev->num_channels = CIO_DAC_NUM_CHAN;
 	indio_dev->name = dev_name(dev);
diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index 5d1819448102..cde835e7566c 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -179,7 +179,6 @@ static int dpot_dac_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &dpot_dac_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &dpot_dac_iio_channel;
 	indio_dev->num_channels = 1;
 
diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 79527fbc250a..cd54f8e706cf 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -267,7 +267,6 @@ static int ds4424_probe(struct i2c_client *client,
 	}
 
 	indio_dev->channels = ds4424_channels;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ds4424_info;
 
 	ret = iio_device_register(indio_dev);
diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
index 9e38607a189e..87356e500c44 100644
--- a/drivers/iio/dac/lpc18xx_dac.c
+++ b/drivers/iio/dac/lpc18xx_dac.c
@@ -134,7 +134,6 @@ static int lpc18xx_dac_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &lpc18xx_dac_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = lpc18xx_dac_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lpc18xx_dac_iio_channels);
 
diff --git a/drivers/iio/dac/ltc1660.c b/drivers/iio/dac/ltc1660.c
index dc10188540ca..041dea727cd6 100644
--- a/drivers/iio/dac/ltc1660.c
+++ b/drivers/iio/dac/ltc1660.c
@@ -187,7 +187,6 @@ static int ltc1660_probe(struct spi_device *spi)
 	priv->spi = spi;
 	spi_set_drvdata(spi, indio_dev);
 	indio_dev->info = &ltc1660_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ltc1660_channels[id->driver_data];
 	indio_dev->num_channels = LTC1660_NUM_CHANNELS;
 	indio_dev->name = id->name;
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 4002ed0868be..d4c2b033d4cb 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -365,7 +365,6 @@ static int ltc2632_probe(struct spi_device *spi)
 	indio_dev->name = dev_of_node(&spi->dev) ? dev_of_node(&spi->dev)->name
 						 : spi_get_device_id(spi)->name;
 	indio_dev->info = &ltc2632_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
 
diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 225b1a374dc1..29c029f38618 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -206,7 +206,6 @@ static int m62332_probe(struct i2c_client *client,
 
 	indio_dev->num_channels = ARRAY_SIZE(m62332_channels);
 	indio_dev->channels = m62332_channels;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &m62332_info;
 
 	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index daa60386bf0c..238f0a809cf6 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -172,7 +172,6 @@ static int max517_probe(struct i2c_client *client,
 		break;
 	}
 	indio_dev->channels = max517_channels;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &max517_info;
 
 	/*
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index d6bb24db49c4..757f7c8c361f 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -343,7 +343,6 @@ static int max5821_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->num_channels = ARRAY_SIZE(max5821_channels);
 	indio_dev->channels = max5821_channels;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &max5821_info;
 
 	return iio_device_register(indio_dev);
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index beb9a15b7c74..b277d16b6dec 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -444,7 +444,6 @@ static int mcp4725_probe(struct i2c_client *client,
 	indio_dev->info = &mcp4725_info;
 	indio_dev->channels = &mcp472x_channel[id->driver_data];
 	indio_dev->num_channels = 1;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* read current DAC value and settings */
 	err = i2c_master_recv(client, inbuf, data->id == MCP4725 ? 3 : 4);
diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index c4e430b4050e..a8b4162a4b57 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -153,7 +153,6 @@ static int mcp4922_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	id = spi_get_device_id(spi);
 	indio_dev->info = &mcp4922_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mcp4922_channels[id->driver_data];
 	indio_dev->num_channels = MCP4922_NUM_CHANNELS;
 	indio_dev->name = id->name;
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 12dec68c16f7..a463b24f5e56 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -328,7 +328,6 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->dev.of_node = pdev->dev.of_node;
 	indio_dev->info = &stm32_dac_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	mutex_init(&dac->lock);
 
diff --git a/drivers/iio/dac/ti-dac082s085.c b/drivers/iio/dac/ti-dac082s085.c
index de33c1fc6e0b..3dad6cdb7797 100644
--- a/drivers/iio/dac/ti-dac082s085.c
+++ b/drivers/iio/dac/ti-dac082s085.c
@@ -271,7 +271,6 @@ static int ti_dac_probe(struct spi_device *spi)
 
 	indio_dev->info = &ti_dac_info;
 	indio_dev->name = spi->modalias;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ti_dac_channels;
 	spi_set_drvdata(spi, indio_dev);
 
diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index d3295767a079..840e8062236f 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -323,7 +323,6 @@ static int dac5571_probe(struct i2c_client *client,
 
 	indio_dev->info = &dac5571_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = dac5571_channels;
 
 	spec = &dac5571_spec[id->driver_data];
diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
index 63171e42f987..e7f3421da9d0 100644
--- a/drivers/iio/dac/ti-dac7311.c
+++ b/drivers/iio/dac/ti-dac7311.c
@@ -253,7 +253,6 @@ static int ti_dac_probe(struct spi_device *spi)
 
 	indio_dev->info = &ti_dac_info;
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ti_dac_channels;
 	spi_set_drvdata(spi, indio_dev);
 
diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
index 4c0f4b5e9ff4..08f12c913881 100644
--- a/drivers/iio/dac/ti-dac7612.c
+++ b/drivers/iio/dac/ti-dac7612.c
@@ -148,7 +148,6 @@ static int dac7612_probe(struct spi_device *spi)
 	priv->spi = spi;
 	spi_set_drvdata(spi, iio_dev);
 	iio_dev->info = &dac7612_info;
-	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->channels = dac7612_channels;
 	iio_dev->num_channels = ARRAY_SIZE(priv->cache);
 	iio_dev->name = spi_get_device_id(spi)->name;
diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index 636b4009f763..e97382bd26db 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -200,7 +200,6 @@ static int vf610_dac_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &vf610_dac_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = vf610_dac_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vf610_dac_iio_channels);
 
diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index 06baa356e264..b71e729e1785 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -623,9 +623,6 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 */
 	indio_dev->info = &iio_dummy_info;
 
-	/* Specify that device provides sysfs type interfaces */
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
 	ret = iio_simple_dummy_events_register(parent, indio_dev);
 	if (ret < 0)
 		return ERR_PTR(ret);
diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index bdb0bc3b12dd..880cf13fb383 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -1035,7 +1035,6 @@ static int ad9523_probe(struct spi_device *spi)
 	indio_dev->name = (pdata->name[0] != 0) ? pdata->name :
 			  spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9523_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->ad9523_channels;
 	indio_dev->num_channels = pdata->num_channels;
 
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 82c050a3899d..e922333b8a6a 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -542,7 +542,6 @@ static int adf4350_probe(struct spi_device *spi)
 		spi_get_device_id(spi)->name;
 
 	indio_dev->info = &adf4350_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &adf4350_chan;
 	indio_dev->num_channels = 1;
 
diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index ecd5e18995ad..76159f723ea5 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -575,7 +575,6 @@ static int adf4371_probe(struct spi_device *spi)
 	st->chip_info = &adf4371_chip_info[id->driver_data];
 	indio_dev->name = id->name;
 	indio_dev->info = &adf4371_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
index e2f4d943e220..1231ed113929 100644
--- a/drivers/iio/gyro/adis16080.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -208,7 +208,6 @@ static int adis16080_probe(struct spi_device *spi)
 	indio_dev->channels = adis16080_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16080_channels);
 	indio_dev->info = &adis16080_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	return iio_device_register(indio_dev);
 }
diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
index b9c952e65b55..58d37c6c6c9e 100644
--- a/drivers/iio/gyro/adis16130.c
+++ b/drivers/iio/gyro/adis16130.c
@@ -156,7 +156,6 @@ static int adis16130_probe(struct spi_device *spi)
 	indio_dev->channels = adis16130_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16130_channels);
 	indio_dev->info = &adis16130_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index a11ae9db0d11..e8459016210f 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -549,7 +549,6 @@ static int adis16136_probe(struct spi_device *spi)
 	indio_dev->channels = adis16136_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16136_channels);
 	indio_dev->info = &adis16136_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	adis16136_data = &adis16136->chip_info->adis_data;
 
diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index e7c9a3e31c45..4cc70f3eac90 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -389,7 +389,6 @@ static int adis16260_probe(struct spi_device *spi)
 	indio_dev->info = &adis16260_info;
 	indio_dev->channels = adis16260->info->channels;
 	indio_dev->num_channels = adis16260->info->num_channels;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis_init(&adis16260->adis, indio_dev, spi, &adis16260_data);
 	if (ret)
diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index c45d8226cc2b..847025e13703 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -630,7 +630,6 @@ static int adxrs290_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->name = "adxrs290";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxrs290_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxrs290_channels);
 	indio_dev->info = &adxrs290_info;
diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index 04f350025215..c20c8b5dc5c3 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -425,7 +425,6 @@ static int adxrs450_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->info = &adxrs450_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels =
 		adxrs450_channels[spi_get_device_id(spi)->driver_data];
 	indio_dev->num_channels = ARRAY_SIZE(adxrs450_channels);
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 2d5015801a75..04cb88458084 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1095,7 +1095,6 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	indio_dev->num_channels = ARRAY_SIZE(bmg160_channels);
 	indio_dev->name = name;
 	indio_dev->available_scan_masks = bmg160_accel_scan_masks;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmg160_info;
 
 	if (data->irq > 0) {
diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 129eead8febc..b15f4de3356e 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -974,7 +974,6 @@ int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	indio_dev->channels = fxas21002c_channels;
 	indio_dev->num_channels = ARRAY_SIZE(fxas21002c_channels);
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &fxas21002c_info;
 
 	ret = fxas21002c_trigger_probe(data);
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 6698f5f535f6..4d94a6a4dd5a 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -321,7 +321,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(gyro_3d_channels);
 	indio_dev->info = &gyro_3d_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&gyro_state->common_attributes.data_ready, 0);
 
diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index e9804664db73..4f296d640eb9 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -321,7 +321,6 @@ static int itg3200_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(itg3200_channels);
 	indio_dev->available_scan_masks = itg3200_available_scan_masks;
 	indio_dev->info = &itg3200_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = itg3200_buffer_configure(indio_dev);
 	if (ret)
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index dfa31a23500f..9f18129d3160 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1204,7 +1204,6 @@ int mpu3050_common_probe(struct device *dev,
 	indio_dev->num_channels = ARRAY_SIZE(mpu3050_channels);
 	indio_dev->info = &mpu3050_info;
 	indio_dev->available_scan_masks = mpu3050_scan_masks;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 
 	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 38734e4ce360..c1d50c263292 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -511,7 +511,6 @@ static int afe4403_probe(struct spi_device *spi)
 		goto err_disable_reg;
 	}
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = afe4403_channels;
 	indio_dev->num_channels = ARRAY_SIZE(afe4403_channels);
 	indio_dev->name = AFE4403_DRIVER_NAME;
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 61fe4932d81d..fab2dc86f3e6 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -518,7 +518,6 @@ static int afe4404_probe(struct i2c_client *client,
 		goto disable_reg;
 	}
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = afe4404_channels;
 	indio_dev->num_channels = ARRAY_SIZE(afe4404_channels);
 	indio_dev->name = AFE4404_DRIVER_NAME;
diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 02ad1767c845..17a30e1db406 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -235,7 +235,6 @@ static int am2315_probe(struct i2c_client *client,
 
 	indio_dev->info = &am2315_info;
 	indio_dev->name = AM2315_DRIVER_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = am2315_channels;
 	indio_dev->num_channels = ARRAY_SIZE(am2315_channels);
 
diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 9a7819817488..cad5fd9b0670 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -322,7 +322,6 @@ static int dht11_probe(struct platform_device *pdev)
 	mutex_init(&dht11->lock);
 	iio->name = pdev->name;
 	iio->info = &dht11_iio_info;
-	iio->modes = INDIO_DIRECT_MODE;
 	iio->channels = dht11_chan_spec;
 	iio->num_channels = ARRAY_SIZE(dht11_chan_spec);
 
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 2a957f19048e..4b6b575b1229 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -370,7 +370,6 @@ static int hdc100x_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 
 	indio_dev->name = dev_name(&client->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &hdc100x_info;
 
 	indio_dev->channels = hdc100x_channels;
diff --git a/drivers/iio/humidity/hdc2010.c b/drivers/iio/humidity/hdc2010.c
index 83f5b9f60780..9e530420e79c 100644
--- a/drivers/iio/humidity/hdc2010.c
+++ b/drivers/iio/humidity/hdc2010.c
@@ -278,7 +278,6 @@ static int hdc2010_probe(struct i2c_client *client,
 	 * HDC2010 and HDC2080, we have the name hardcoded
 	 */
 	indio_dev->name = "hdc2010";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &hdc2010_info;
 
 	indio_dev->channels = hdc2010_channels;
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 52f605114ef7..d98fc19cf9ae 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -228,7 +228,6 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(humidity_channels);
 	indio_dev->info = &humidity_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&humid_st->common_attributes.data_ready, 0);
 
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 6a39615b6961..b55a61236073 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -608,7 +608,6 @@ int hts221_probe(struct device *dev, int irq, const char *name,
 	if (err < 0)
 		return err;
 
-	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->available_scan_masks = hts221_scan_masks;
 	iio_dev->channels = hts221_channels;
 	iio_dev->num_channels = ARRAY_SIZE(hts221_channels);
diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index 36df2a102ca4..3a8d872d60f7 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -205,7 +205,6 @@ static int htu21_probe(struct i2c_client *client,
 
 	indio_dev->info = &htu21_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (id->driver_data == MS8607) {
 		indio_dev->channels = ms8607_channels;
diff --git a/drivers/iio/humidity/si7005.c b/drivers/iio/humidity/si7005.c
index 160b3d92df61..35c2ec805b24 100644
--- a/drivers/iio/humidity/si7005.c
+++ b/drivers/iio/humidity/si7005.c
@@ -143,7 +143,6 @@ static int si7005_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 
 	indio_dev->name = dev_name(&client->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &si7005_info;
 
 	indio_dev->channels = si7005_channels;
diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index ab6537f136ba..9f19567e9192 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -130,7 +130,6 @@ static int si7020_probe(struct i2c_client *client,
 	*data = client;
 
 	indio_dev->name = dev_name(&client->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &si7020_info;
 	indio_dev->channels = si7020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(si7020_channels);
diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 54af2ed664f6..e7627bf68ccb 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -1190,7 +1190,6 @@ static int adis16400_probe(struct spi_device *spi)
 	indio_dev->channels = st->variant->channels;
 	indio_dev->num_channels = st->variant->num_channels;
 	indio_dev->info = &adis16400_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
 		adis16400_setup_chan_mask(st);
diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 74a161e39733..09b4a8566dcf 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -397,7 +397,6 @@ static int adis16460_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = &adis16460_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis_init(&st->adis, indio_dev, spi, &adis16460_data);
 	if (ret)
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 197d48240991..27a4904dff41 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1281,7 +1281,6 @@ static int adis16475_probe(struct spi_device *spi)
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
 	indio_dev->info = &adis16475_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = __adis_initial_startup(&st->adis);
 	if (ret)
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index dfe86c589325..d8027a545b28 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1243,7 +1243,6 @@ static int adis16480_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = &adis16480_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	adis16480_data = &st->chip_info->adis_data;
 
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 290b5ef83f77..84ebd42699ae 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -870,7 +870,6 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->channels = bmi160_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmi160_channels);
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi160_info;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index ab288186f36e..fa833b8e458d 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -636,7 +636,6 @@ int fxos8700_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->channels = fxos8700_channels;
 	indio_dev->num_channels = ARRAY_SIZE(fxos8700_channels);
 	indio_dev->name = name ? name : "fxos8700";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &fxos8700_info;
 
 	return devm_iio_device_register(dev, indio_dev);
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 4377047d503a..8839926c6314 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1247,7 +1247,6 @@ static struct iio_dev *kmx61_indiodev_setup(struct kmx61_data *data,
 	indio_dev->channels = chan;
 	indio_dev->num_channels = num_channels;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = info;
 
 	return indio_dev;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 467214e2e77c..70b5c4185390 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1985,7 +1985,6 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	if (!iio_dev)
 		return NULL;
 
-	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->available_scan_masks = st_lsm6dsx_available_scan_masks;
 	iio_dev->channels = hw->settings->channels[id].chan;
 	iio_dev->num_channels = hw->settings->channels[id].len;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 99562ba85ee4..ffd682415ce7 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -738,7 +738,6 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	if (!iio_dev)
 		return NULL;
 
-	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->info = &st_lsm6dsx_ext_info;
 
 	sensor = iio_priv(iio_dev);
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 17dac8d0e11d..f0c7f9b4f97d 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -263,7 +263,6 @@ static int adjd_s311_probe(struct i2c_client *client,
 	indio_dev->name = ADJD_S311_DRV_NAME;
 	indio_dev->channels = adjd_s311_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adjd_s311_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	err = iio_triggered_buffer_setup(indio_dev, NULL,
 		adjd_s311_trigger_handler, NULL);
diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 9aa28695e6f1..ab28f93dfa7e 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -789,7 +789,6 @@ static int adux1020_probe(struct i2c_client *client,
 	indio_dev->name = ADUX1020_DRV_NAME;
 	indio_dev->channels = adux1020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adux1020_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	data = iio_priv(indio_dev);
 
diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index b4e9924094cd..e0c31090c7d7 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -183,7 +183,6 @@ static int al3010_probe(struct i2c_client *client,
 	indio_dev->name = AL3010_DRV_NAME;
 	indio_dev->channels = al3010_channels;
 	indio_dev->num_channels = ARRAY_SIZE(al3010_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = al3010_init(data);
 	if (ret < 0) {
diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index cc1407ccc10a..7f2e6b087659 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -206,7 +206,6 @@ static int al3320a_probe(struct i2c_client *client,
 	indio_dev->name = AL3320A_DRV_NAME;
 	indio_dev->channels = al3320a_channels;
 	indio_dev->num_channels = ARRAY_SIZE(al3320a_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = al3320a_init(data);
 	if (ret < 0) {
diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index baaf202dce05..a184519c0ca5 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -422,7 +422,6 @@ static int apds9300_probe(struct i2c_client *client,
 	indio_dev->channels = apds9300_channels;
 	indio_dev->num_channels = ARRAY_SIZE(apds9300_channels);
 	indio_dev->name = APDS9300_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (client->irq)
 		indio_dev->info = &apds9300_info;
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 7b32dfaee9b3..69fdef467345 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -684,7 +684,6 @@ static int as73211_probe(struct i2c_client *client)
 	indio_dev->name = AS73211_DRV_NAME;
 	indio_dev->channels = as73211_channels;
 	indio_dev->num_channels = ARRAY_SIZE(as73211_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
 	if (ret < 0)
diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 48484b9401b9..a4b503f470a3 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -258,7 +258,6 @@ static int bh1750_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->channels = bh1750_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bh1750_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	return iio_device_register(indio_dev);
 }
diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index abbf2e662e7d..2c4e4b1e03fd 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -189,7 +189,6 @@ static int bh1780_probe(struct i2c_client *client,
 	indio_dev->name = "bh1780";
 	indio_dev->channels = bh1780_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bh1780_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 97649944f1df..ef6c63945552 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -469,7 +469,6 @@ static int cm32181_probe(struct i2c_client *client)
 	indio_dev->num_channels = ARRAY_SIZE(cm32181_channels);
 	indio_dev->info = &cm32181_info;
 	indio_dev->name = dev_name(dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = cm32181_reg_init(cm32181);
 	if (ret) {
diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 18a410340dc5..615041b99f6d 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -344,7 +344,6 @@ static int cm3232_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(cm3232_channels);
 	indio_dev->info = &cm3232_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = cm3232_reg_init(chip);
 	if (ret) {
diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 6d1b0ffd144b..ecf4397b9c22 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -235,7 +235,6 @@ static int cm3323_probe(struct i2c_client *client,
 	indio_dev->name = CM3323_DRV_NAME;
 	indio_dev->channels = cm3323_channels;
 	indio_dev->num_channels = ARRAY_SIZE(cm3323_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = cm3323_init(indio_dev);
 	if (ret < 0) {
diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 4c83953672be..a61df13d4765 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -243,7 +243,6 @@ static int cm3605_probe(struct platform_device *pdev)
 	indio_dev->name = "cm3605";
 	indio_dev->channels = cm3605_channels;
 	indio_dev->num_channels = ARRAY_SIZE(cm3605_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index fd83a19929bc..5b7bb8c4d37d 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -666,7 +666,6 @@ static int cm36651_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(cm36651_channels);
 	indio_dev->info = &cm36651_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = cm36651_setup_reg(cm36651);
 	if (ret) {
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 7ba7aa59437c..afe52b18632e 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -604,7 +604,6 @@ static int gp2ap002_probe(struct i2c_client *client,
 	if (gp2ap002->is_gp2ap002s00f)
 		num_chan--;
 	indio_dev->num_channels = num_chan;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index e2850c1a7353..3a07ffe3e91c 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1521,7 +1521,6 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(gp2ap020a00f_channels);
 	indio_dev->info = &gp2ap020a00f_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Allocate buffer */
 	err = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index a21c827e4953..93be8997de4c 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -303,7 +303,6 @@ static int hid_als_probe(struct platform_device *pdev)
 				ARRAY_SIZE(als_channels);
 	indio_dev->info = &als_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&als_state->common_attributes.data_ready, 0);
 
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 330cf359e0b8..7dc69af0966b 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -281,7 +281,6 @@ static int hid_prox_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(prox_channels);
 	indio_dev->info = &prox_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&prox_state->common_attributes.data_ready, 0);
 
diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
index 004ea890a4b2..814aec540a21 100644
--- a/drivers/iio/light/iqs621-als.c
+++ b/drivers/iio/light/iqs621-als.c
@@ -581,7 +581,6 @@ static int iqs621_als_probe(struct platform_device *pdev)
 		indio_dev->num_channels = ARRAY_SIZE(iqs621_als_channels);
 	}
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = iqs62x->dev_desc->dev_name;
 	indio_dev->info = &iqs621_als_info;
 
diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 2689867467a8..40149d417f84 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -779,7 +779,6 @@ static int isl29018_probe(struct i2c_client *client,
 	indio_dev->channels = isl29018_chip_info_tbl[dev_id].channels;
 	indio_dev->num_channels = isl29018_chip_info_tbl[dev_id].num_channels;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 2f8b494f3e08..863b1a8c21a3 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -620,7 +620,6 @@ static int isl29028_probe(struct i2c_client *client,
 	indio_dev->channels = isl29028_channels;
 	indio_dev->num_channels = ARRAY_SIZE(isl29028_channels);
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev,
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index b93b85dbc3a6..51da5bbbe3b9 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -256,7 +256,6 @@ static int isl29125_probe(struct i2c_client *client,
 	indio_dev->name = ISL29125_DRV_NAME;
 	indio_dev->channels = isl29125_channels;
 	indio_dev->num_channels = ARRAY_SIZE(isl29125_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = i2c_smbus_read_byte_data(data->client, ISL29125_DEVICE_ID);
 	if (ret < 0)
diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index 724a0ec9f35c..a4399836891a 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -341,7 +341,6 @@ static int jsa1212_probe(struct i2c_client *client,
 	indio_dev->channels = jsa1212_channels;
 	indio_dev->num_channels = ARRAY_SIZE(jsa1212_channels);
 	indio_dev->name = JSA1212_DRIVER_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->info = &jsa1212_info;
 
diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 8a621244dd01..b387ce3de587 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -853,7 +853,6 @@ static int lm3533_als_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
 	indio_dev->name = dev_name(&pdev->dev);
 	iio_device_set_parent(indio_dev, pdev->dev.parent);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	als = iio_priv(indio_dev);
 	als->lm3533 = lm3533;
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index b4323d2db0b1..61a3595dac71 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1487,7 +1487,6 @@ static int ltr501_probe(struct i2c_client *client,
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->no_channels;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ltr501_init(data);
 	if (ret < 0)
diff --git a/drivers/iio/light/lv0104cs.c b/drivers/iio/light/lv0104cs.c
index c2aef88f4e63..c965ae4f4ac8 100644
--- a/drivers/iio/light/lv0104cs.c
+++ b/drivers/iio/light/lv0104cs.c
@@ -501,7 +501,6 @@ static int lv0104cs_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = lv0104cs_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lv0104cs_channels);
 	indio_dev->name = client->name;
diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 801e5a0ad496..34b48338aa06 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -502,7 +502,6 @@ static int max44009_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	indio_dev->info = &max44009_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = MAX44009_DRV_NAME;
 	indio_dev->channels = max44009_channels;
 	indio_dev->num_channels = ARRAY_SIZE(max44009_channels);
diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index a308fbc2fc7b..a1654029588b 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -274,7 +274,6 @@ static int noa1305_probe(struct i2c_client *client,
 	indio_dev->channels = noa1305_channels;
 	indio_dev->num_channels = ARRAY_SIZE(noa1305_channels);
 	indio_dev->name = NOA1305_DRIVER_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret)
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 2d48d61909a4..51ca8281ae96 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -768,7 +768,6 @@ static int opt3001_probe(struct i2c_client *client,
 	iio->name = client->name;
 	iio->channels = opt3001_channels;
 	iio->num_channels = ARRAY_SIZE(opt3001_channels);
-	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &opt3001_info;
 
 	ret = devm_iio_device_register(dev, iio);
diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index bfade6577a38..d5eb7b70a62e 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -366,7 +366,6 @@ static int pa12203001_probe(struct i2c_client *client,
 	indio_dev->name = PA12203001_DRIVER_NAME;
 	indio_dev->channels = pa12203001_channels;
 	indio_dev->num_channels = ARRAY_SIZE(pa12203001_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = pa12203001_init(indio_dev);
 	if (ret < 0)
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 31224a33bade..c870033b868c 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -959,7 +959,6 @@ static int rpr0521_probe(struct i2c_client *client,
 	indio_dev->name = RPR0521_DRV_NAME;
 	indio_dev->channels = rpr0521_channels;
 	indio_dev->num_channels = ARRAY_SIZE(rpr0521_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = rpr0521_init(data);
 	if (ret < 0) {
diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index c280b4195003..f908ea7d796e 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -1019,7 +1019,6 @@ static int si1133_probe(struct i2c_client *client,
 	iio_dev->channels = si1133_channels;
 	iio_dev->num_channels = ARRAY_SIZE(si1133_channels);
 	iio_dev->info = &si1133_info;
-	iio_dev->modes = INDIO_DIRECT_MODE;
 
 	mutex_init(&data->mutex);
 
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index b304801c7916..6392a9e80699 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1312,7 +1312,6 @@ static int si1145_probe(struct i2c_client *client,
 	indio_dev->channels = data->part_info->channels;
 	indio_dev->num_channels = data->part_info->num_channels;
 	indio_dev->info = data->part_info->iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	mutex_init(&data->lock);
 	mutex_init(&data->cmdlock);
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index 1055594b2276..0014bc901c32 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -302,7 +302,6 @@ int st_uvis25_probe(struct device *dev, int irq, struct regmap *regmap)
 	if (err < 0)
 		return err;
 
-	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->channels = st_uvis25_channels;
 	iio_dev->num_channels = ARRAY_SIZE(st_uvis25_channels);
 	iio_dev->name = ST_UVIS25_DEV_NAME;
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index a2827d03ab0f..e32d8690f25b 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -589,7 +589,6 @@ static int stk3310_probe(struct i2c_client *client,
 
 	indio_dev->info = &stk3310_info;
 	indio_dev->name = STK3310_DRIVER_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = stk3310_channels;
 	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
 
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 6fe5d46f80d4..4722acbc6ef8 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -282,7 +282,6 @@ static int tcs3414_probe(struct i2c_client *client,
 	indio_dev->name = TCS3414_DRV_NAME;
 	indio_dev->channels = tcs3414_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tcs3414_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = i2c_smbus_read_byte_data(data->client, TCS3414_ID);
 	if (ret < 0)
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index a0dc447aeb68..8441b0113825 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -458,7 +458,6 @@ static int tcs3472_probe(struct i2c_client *client,
 	indio_dev->name = TCS3472_DRV_NAME;
 	indio_dev->channels = tcs3472_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tcs3472_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = i2c_smbus_read_byte_data(data->client, TCS3472_ID);
 	if (ret < 0)
diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 5bf2bfbc5379..34ff8279e749 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -752,7 +752,6 @@ static int tsl2563_probe(struct i2c_client *client,
 	indio_dev->name = client->name;
 	indio_dev->channels = tsl2563_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tsl2563_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (client->irq)
 		indio_dev->info = &tsl2563_info;
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 9e5490b7473b..27ef08431b12 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -840,7 +840,6 @@ static int tsl2583_probe(struct i2c_client *clientp,
 	indio_dev->info = &tsl2583_info;
 	indio_dev->channels = tsl2583_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tsl2583_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = chip->client->name;
 
 	pm_runtime_enable(&clientp->dev);
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index d79205361dfa..304834e6c3ba 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1827,7 +1827,6 @@ static int tsl2772_probe(struct i2c_client *clientp,
 		&tsl2772_chip_info_tbl[device_channel_config[id->driver_data]];
 
 	indio_dev->info = chip->chip_info->info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = chip->client->name;
 	indio_dev->num_channels = chip->chip_info->chan_table_elements;
 
diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index 70505ba6d858..87932e12a56d 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -196,7 +196,6 @@ static int tsl4531_probe(struct i2c_client *client,
 	indio_dev->channels = tsl4531_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tsl4531_channels);
 	indio_dev->name = TSL4531_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	return iio_device_register(indio_dev);
 }
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 393f27b75c75..addda7286020 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -855,7 +855,6 @@ static int us5182d_probe(struct i2c_client *client,
 	indio_dev->name = US5182D_DRV_NAME;
 	indio_dev->channels = us5182d_channels;
 	indio_dev->num_channels = ARRAY_SIZE(us5182d_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = i2c_smbus_read_byte_data(data->client, US5182D_REG_CHIPID);
 	if (ret != US5182D_CHIPID) {
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index fff4b36b8b58..ed86e399cbf9 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1041,7 +1041,6 @@ static int vcnl4000_probe(struct i2c_client *client,
 	indio_dev->channels = data->chip_spec->channels;
 	indio_dev->num_channels = data->chip_spec->num_channels;
 	indio_dev->name = VCNL4000_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (client->irq && data->chip_spec->irq_support) {
 		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 73a28e30dddc..2716edef889f 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -568,7 +568,6 @@ static int vcnl4035_probe(struct i2c_client *client,
 	indio_dev->name = VCNL4035_DRV_NAME;
 	indio_dev->channels = vcnl4035_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vcnl4035_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = vcnl4035_init(data);
 	if (ret < 0) {
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index de85c9b30be1..5f6706e96ab9 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -817,7 +817,6 @@ static int veml6030_probe(struct i2c_client *client,
 	indio_dev->name = "veml6030";
 	indio_dev->channels = veml6030_channels;
 	indio_dev->num_channels = ARRAY_SIZE(veml6030_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 1e55e09a8d16..d1c581bfa2b8 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -155,7 +155,6 @@ static int veml6070_probe(struct i2c_client *client,
 	indio_dev->channels = veml6070_channels;
 	indio_dev->num_channels = ARRAY_SIZE(veml6070_channels);
 	indio_dev->name = VEML6070_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	data->client2 = i2c_new_dummy_device(client->adapter, VEML6070_ADDR_DATA_LSB);
 	if (IS_ERR(data->client2)) {
diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 4775bd785e50..44a2b0d8d4bb 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -513,7 +513,6 @@ static int vl6180_probe(struct i2c_client *client,
 	indio_dev->channels = vl6180_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vl6180_channels);
 	indio_dev->name = VL6180_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = vl6180_init(data);
 	if (ret < 0)
diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
index e0bc9df9c88b..ed75a90d53a9 100644
--- a/drivers/iio/light/zopt2201.c
+++ b/drivers/iio/light/zopt2201.c
@@ -531,7 +531,6 @@ static int zopt2201_probe(struct i2c_client *client,
 	indio_dev->channels = zopt2201_channels;
 	indio_dev->num_channels = ARRAY_SIZE(zopt2201_channels);
 	indio_dev->name = ZOPT2201_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	data->rate = ZOPT2201_MEAS_FREQ_100MS;
 	ret = zopt2201_set_resolution(data, ZOPT2201_MEAS_RES_18BIT);
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 24b2f7b1fe44..cfd75322a822 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -905,7 +905,6 @@ static int ak8974_probe(struct i2c_client *i2c,
 	}
 	indio_dev->info = &ak8974_info;
 	indio_dev->available_scan_masks = ak8974_scan_masks;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = ak8974->name;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index d988b6ac3659..0df94884f0db 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -948,7 +948,6 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
 	indio_dev->info = &ak8975_info;
 	indio_dev->available_scan_masks = ak8975_scan_masks;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 
 	err = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index fa09fcab620a..09932b65da1e 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -885,7 +885,6 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->num_channels = ARRAY_SIZE(bmc150_magn_channels);
 	indio_dev->available_scan_masks = bmc150_magn_scan_masks;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_magn_info;
 
 	if (irq > 0) {
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 97642ebd9168..a4ecba3dad98 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -514,7 +514,6 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	indio_dev->num_channels = chan_count;
 	indio_dev->info = &magn_3d_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&magn_state->magn_flux_attributes.data_ready, 0);
 
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 780faea61d82..4a6ea3577225 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -644,7 +644,6 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 
 	indio_dev->name = name;
 	indio_dev->info = &hmc5843_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = data->variant->channels;
 	indio_dev->num_channels = 4;
 	indio_dev->available_scan_masks = hmc5843_scan_masks;
diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index c96415a1aead..e874274b9079 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -516,7 +516,6 @@ static int mag3110_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->info = &mag3110_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mag3110_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mag3110_channels);
 	indio_dev->available_scan_masks = mag3110_scan_masks;
diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 65f3d1ed0d59..12ddbff8bde8 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -511,7 +511,6 @@ static int mmc35240_probe(struct i2c_client *client,
 	indio_dev->name = MMC35240_DRV_NAME;
 	indio_dev->channels = mmc35240_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mmc35240_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = mmc35240_init(data);
 	if (ret < 0) {
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index d54ae5cbe51b..973551629b5a 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -394,7 +394,6 @@ static int mux_probe(struct platform_device *pdev)
 
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &mux_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mux->chan;
 	indio_dev->num_channels = children;
 	if (sizeof_ext_info) {
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index ae132a93bcae..f7799c5b5b8b 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -341,7 +341,6 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(incl_3d_channels);
 	indio_dev->info = &incl_3d_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&incl_state->common_attributes.data_ready, 0);
 
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 23bc61a7f018..605bbafe1a71 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -283,7 +283,6 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(dev_rot_channels);
 	indio_dev->info = &dev_rot_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&rot_state->common_attributes.data_ready, 0);
 
diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs624-pos.c
index 4d7452314209..a86786547d12 100644
--- a/drivers/iio/position/iqs624-pos.c
+++ b/drivers/iio/position/iqs624-pos.c
@@ -246,7 +246,6 @@ static int iqs624_pos_probe(struct platform_device *pdev)
 	iqs624_pos->iqs62x = iqs62x;
 	iqs624_pos->indio_dev = indio_dev;
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = iqs624_pos_channels;
 	indio_dev->num_channels = ARRAY_SIZE(iqs624_pos_channels);
 	indio_dev->name = iqs62x->dev_desc->dev_name;
diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index a88ed0eb3adc..f5e07f365ae2 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -146,7 +146,6 @@ static int max5481_probe(struct spi_device *spi)
 		data->cfg = &max5481_cfg[id->driver_data];
 
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* variant specific configuration */
 	indio_dev->info = &max5481_info;
diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
index 7ec51976ec99..368efc528a07 100644
--- a/drivers/iio/potentiometer/max5487.c
+++ b/drivers/iio/potentiometer/max5487.c
@@ -100,7 +100,6 @@ static int max5487_spi_probe(struct spi_device *spi)
 
 	indio_dev->info = &max5487_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = max5487_channels;
 	indio_dev->num_channels = ARRAY_SIZE(max5487_channels);
 
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index f34ca769dc20..6fc6ba6e9296 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -311,7 +311,6 @@ static int lmp91000_probe(struct i2c_client *client,
 	indio_dev->channels = lmp91000_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lmp91000_channels);
 	indio_dev->name = LMP91000_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	i2c_set_clientdata(client, indio_dev);
 
 	data = iio_priv(indio_dev);
diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp060mg.c
index e1c3bdb371ee..fb10f15b74a5 100644
--- a/drivers/iio/pressure/abp060mg.c
+++ b/drivers/iio/pressure/abp060mg.c
@@ -195,7 +195,6 @@ static int abp060mg_probe(struct i2c_client *client,
 	abp060mg_init_device(indio_dev, cfg_id);
 
 	indio_dev->name = dev_name(&client->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &abp060mg_info;
 
 	indio_dev->channels = abp060mg_channels;
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6b7da40f99c8..24eeb2f7c529 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1007,7 +1007,6 @@ int bmp280_common_probe(struct device *dev,
 	indio_dev->name = name;
 	indio_dev->channels = bmp280_channels;
 	indio_dev->info = &bmp280_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	switch (chip) {
 	case BMP180_CHIP_ID:
diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index ade73267d5eb..f04098160a9d 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -312,7 +312,6 @@ static int dlh_probe(struct i2c_client *client,
 
 	indio_dev->name = id->name;
 	indio_dev->info = &dlh_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels =  dlh_channels;
 	indio_dev->num_channels = ARRAY_SIZE(dlh_channels);
 
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 0730380ceb69..acb9fda1beca 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -736,7 +736,6 @@ static int dps310_probe(struct i2c_client *client,
 	iio->channels = dps310_channels;
 	iio->num_channels = ARRAY_SIZE(dps310_channels);
 	iio->info = &dps310_info;
-	iio->modes = INDIO_DIRECT_MODE;
 
 	data->regmap = devm_regmap_init_i2c(client, &dps310_regmap_config);
 	if (IS_ERR(data->regmap))
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5c458788f346..4d35da4d2ad6 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -285,7 +285,6 @@ static int hid_press_probe(struct platform_device *pdev)
 				ARRAY_SIZE(press_channels);
 	indio_dev->info = &press_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&press_state->common_attributes.data_ready, 0);
 
diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index e40b1d7dc129..308b209ef0f7 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -228,7 +228,6 @@ static int hp03_probe(struct i2c_client *client,
 	indio_dev->channels = hp03_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hp03_channels);
 	indio_dev->info = &hp03_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	priv->xclr_gpio = devm_gpiod_get_index(dev, "xclr", 0, GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->xclr_gpio)) {
diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
index 986b7a59712e..6361a8c45153 100644
--- a/drivers/iio/pressure/hp206c.c
+++ b/drivers/iio/pressure/hp206c.c
@@ -378,7 +378,6 @@ static int hp206c_probe(struct i2c_client *client,
 
 	indio_dev->info = &hp206c_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = hp206c_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hp206c_channels);
 
diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
index 48759fc4bf18..824b3f67d4a1 100644
--- a/drivers/iio/pressure/icp10100.c
+++ b/drivers/iio/pressure/icp10100.c
@@ -547,7 +547,6 @@ static int icp10100_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->name = client->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = icp10100_channels;
 	indio_dev->num_channels = ARRAY_SIZE(icp10100_channels);
 	indio_dev->info = &icp10100_info;
diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 81f288312a28..0e4cc6198c5d 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -160,7 +160,6 @@ int mpl115_probe(struct device *dev, const char *name,
 
 	indio_dev->info = &mpl115_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mpl115_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mpl115_channels);
 
diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 1eb9e7b29e05..c730e82114a5 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -248,7 +248,6 @@ static int mpl3115_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->info = &mpl3115_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mpl3115_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mpl3115_channels);
 
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 5b59a4137d32..c7ad58793dab 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -153,7 +153,6 @@ static int ms5637_probe(struct i2c_client *client,
 
 	indio_dev->info = &ms5637_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ms5637_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ms5637_channels);
 
diff --git a/drivers/iio/pressure/t5403.c b/drivers/iio/pressure/t5403.c
index 685fcf65334f..44d013890761 100644
--- a/drivers/iio/pressure/t5403.c
+++ b/drivers/iio/pressure/t5403.c
@@ -236,7 +236,6 @@ static int t5403_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->info = &t5403_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = t5403_channels;
 	indio_dev->num_channels = ARRAY_SIZE(t5403_channels);
 
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 2cecbe0adb3f..80bc8cbb49c4 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1595,7 +1595,6 @@ static struct iio_dev *zpa2326_create_managed_iiodev(struct device *device,
 		return NULL;
 
 	/* Setup for userspace synchronous on demand sampling. */
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = zpa2326_channels;
 	indio_dev->num_channels = ARRAY_SIZE(zpa2326_channels);
 	indio_dev->name = name;
diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index b79ada839e01..f32687853272 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -400,7 +400,6 @@ static int as3935_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->channels = as3935_channels;
 	indio_dev->num_channels = ARRAY_SIZE(as3935_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &as3935_info;
 
 	trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index 90e76451c972..ab3f40350f40 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -971,7 +971,6 @@ static int isl29501_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = isl29501_channels;
 	indio_dev->num_channels = ARRAY_SIZE(isl29501_channels);
 	indio_dev->name = client->name;
diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index ad4b1fb2607a..d2af96f4db0d 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -201,7 +201,6 @@ static int mb1232_probe(struct i2c_client *client,
 
 	indio_dev->info = &mb1232_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mb1232_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mb1232_channels);
 
diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
index 1283ac1c2e03..8073b0783e51 100644
--- a/drivers/iio/proximity/ping.c
+++ b/drivers/iio/proximity/ping.c
@@ -310,7 +310,6 @@ static int ping_probe(struct platform_device *pdev)
 
 	indio_dev->name = "ping";
 	indio_dev->info = &ping_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ping_chan_spec;
 	indio_dev->num_channels = ARRAY_SIZE(ping_chan_spec);
 
diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index c685f10b5ae4..d258b384813b 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -271,7 +271,6 @@ static int lidar_probe(struct i2c_client *client,
 	indio_dev->name = LIDAR_DRV_NAME;
 	indio_dev->channels = lidar_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lidar_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	i2c_set_clientdata(client, indio_dev);
 
diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 7a0472323f17..726adf785190 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -278,7 +278,6 @@ static int rfd77402_probe(struct i2c_client *client,
 	indio_dev->channels = rfd77402_channels;
 	indio_dev->num_channels = ARRAY_SIZE(rfd77402_channels);
 	indio_dev->name = RFD77402_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = rfd77402_init(data);
 	if (ret < 0)
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 420c37c72de4..04eea4373e47 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -318,7 +318,6 @@ static int srf04_probe(struct platform_device *pdev)
 
 	indio_dev->name = "srf04";
 	indio_dev->info = &srf04_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = srf04_chan_spec;
 	indio_dev->num_channels = ARRAY_SIZE(srf04_chan_spec);
 
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 70beac5c9c1d..742a1eb3463e 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -483,7 +483,6 @@ static int srf08_probe(struct i2c_client *client,
 	}
 
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = srf08_channels;
 	indio_dev->num_channels = ARRAY_SIZE(srf08_channels);
 
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a2f820997afc..070fc7a4a412 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1430,7 +1430,6 @@ static int sx9310_probe(struct i2c_client *client)
 	indio_dev->channels = sx9310_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sx9310_channels);
 	indio_dev->info = &sx9310_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	i2c_set_clientdata(client, indio_dev);
 
 	ret = sx9310_init_device(indio_dev);
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index acb821cbad46..800cee8d184d 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -926,7 +926,6 @@ static int sx9500_probe(struct i2c_client *client,
 	indio_dev->channels = sx9500_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sx9500_channels);
 	indio_dev->info = &sx9500_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	i2c_set_clientdata(client, indio_dev);
 
 	sx9500_gpio_probe(client, data);
diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 37264f801ad0..375550a84997 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -230,7 +230,6 @@ static int vcnl3020_probe(struct i2c_client *client)
 	indio_dev->channels = vcnl3020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vcnl3020_channels);
 	indio_dev->name = "vcnl3020";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index cf38144b6f95..d2297ace002c 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -209,7 +209,6 @@ static int vl53l0x_probe(struct i2c_client *client)
 	indio_dev->info = &vl53l0x_info;
 	indio_dev->channels = vl53l0x_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* usage of interrupt is optional */
 	if (client->irq) {
diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index 9746bd935628..a68e4481733f 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -159,7 +159,6 @@ static int ad2s1200_probe(struct spi_device *spi)
 	}
 
 	indio_dev->info = &ad2s1200_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1200_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
diff --git a/drivers/iio/resolver/ad2s90.c b/drivers/iio/resolver/ad2s90.c
index d6a91f137e13..6d3ac681ad76 100644
--- a/drivers/iio/resolver/ad2s90.c
+++ b/drivers/iio/resolver/ad2s90.c
@@ -95,7 +95,6 @@ static int ad2s90_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 	st->sdev = spi;
 	indio_dev->info = &ad2s90_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &ad2s90_chan;
 	indio_dev->num_channels = 1;
 	indio_dev->name = spi_get_device_id(spi)->name;
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 81688f1b932f..f00ef1774b16 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -225,7 +225,6 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(temperature_channels);
 	indio_dev->info = &temperature_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&temp_st->common_attributes.data_ready, 0);
 
diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperature/iqs620at-temp.c
index fe126e1fb783..385df2b72b6a 100644
--- a/drivers/iio/temperature/iqs620at-temp.c
+++ b/drivers/iio/temperature/iqs620at-temp.c
@@ -73,7 +73,6 @@ static int iqs620_temp_probe(struct platform_device *pdev)
 
 	iio_device_set_drvdata(indio_dev, iqs62x);
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = iqs620_temp_channels;
 	indio_dev->num_channels = ARRAY_SIZE(iqs620_temp_channels);
 	indio_dev->name = iqs62x->dev_desc->dev_name;
diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 3b5ba26d7d86..326137d0eced 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1510,7 +1510,6 @@ static int ltc2983_probe(struct spi_device *spi)
 	indio_dev->name = name;
 	indio_dev->num_channels = st->iio_channels;
 	indio_dev->channels = st->iio_chan;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ltc2983_iio_info;
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index 1954322e43be..8ef2f9b8c4b8 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -418,7 +418,6 @@ static int max31856_probe(struct spi_device *spi)
 
 	indio_dev->info = &max31856_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = max31856_channels;
 	indio_dev->num_channels = ARRAY_SIZE(max31856_channels);
 
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 0297e215b61a..031360037742 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -243,7 +243,6 @@ static int maxim_thermocouple_probe(struct spi_device *spi)
 	indio_dev->channels = chip->channels;
 	indio_dev->available_scan_masks = chip->scan_masks;
 	indio_dev->num_channels = chip->num_channels;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	data = iio_priv(indio_dev);
 	data->spi = spi;
diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index ef0fec94d269..0b99abee378a 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -526,7 +526,6 @@ static int mlx90614_probe(struct i2c_client *client,
 	mlx90614_wakeup(data);
 
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mlx90614_info;
 
 	ret = mlx90614_probe_num_ir_sensors(client);
diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 503fe54a0bb9..3816f6d50ab5 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -865,7 +865,6 @@ static int mlx90632_probe(struct i2c_client *client,
 
 	mutex_init(&mlx90632->lock);
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mlx90632_info;
 	indio_dev->channels = mlx90632_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mlx90632_channels);
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 54976c7dad92..3bb627481648 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -217,7 +217,6 @@ static int tmp006_probe(struct i2c_client *client,
 	data->client = client;
 
 	indio_dev->name = dev_name(&client->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &tmp006_info;
 
 	indio_dev->channels = tmp006_channels;
diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index ad2b35c65548..856baa326e7f 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -464,7 +464,6 @@ static int tmp007_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 
 	indio_dev->name = "tmp007";
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &tmp007_info;
 
 	indio_dev->channels = tmp007_channels;
diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index fc96e5f9d3fc..76c04327e93b 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -149,7 +149,6 @@ static int tsys02d_probe(struct i2c_client *client,
 
 	indio_dev->info = &tsys02d_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = tsys02d_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tsys02d_channels);
 
diff --git a/drivers/input/touchscreen/tsc2007_iio.c b/drivers/input/touchscreen/tsc2007_iio.c
index 752eb7fe5da3..b0e7840c4917 100644
--- a/drivers/input/touchscreen/tsc2007_iio.c
+++ b/drivers/input/touchscreen/tsc2007_iio.c
@@ -120,7 +120,6 @@ int tsc2007_iio_configure(struct tsc2007 *ts)
 
 	indio_dev->name = "tsc2007";
 	indio_dev->info = &tsc2007_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = tsc2007_iio_channel;
 	indio_dev->num_channels = ARRAY_SIZE(tsc2007_iio_channel);
 
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index e557d757c647..d423b3cbb3d6 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3124,7 +3124,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 
 		dev->indio_dev->info = &toshiba_iio_accel_info;
 		dev->indio_dev->name = "Toshiba accelerometer";
-		dev->indio_dev->modes = INDIO_DIRECT_MODE;
 		dev->indio_dev->channels = toshiba_iio_accel_channels;
 		dev->indio_dev->num_channels =
 					ARRAY_SIZE(toshiba_iio_accel_channels);
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index b68304da288b..b606bc3131f9 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -280,7 +280,6 @@ static int adis16203_probe(struct spi_device *spi)
 	indio_dev->channels = adis16203_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
 	indio_dev->info = &adis16203_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis_init(st, indio_dev, spi, &adis16203_data);
 	if (ret)
diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 8d3afc6dc755..ab85edd9e9c0 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -403,7 +403,6 @@ static int adis16240_probe(struct spi_device *spi)
 	indio_dev->info = &adis16240_info;
 	indio_dev->channels = adis16240_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	spi->mode = SPI_MODE_3;
 	ret = spi_setup(spi);
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index fef0055b8990..66532683a642 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -978,7 +978,6 @@ static int ad7280_probe(struct spi_device *spi)
 	st->readback_delay_us += 5; /* Add tWAIT */
 
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ad7280_channel_init(st);
 	if (ret < 0)
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd67..1220753f5857 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -395,7 +395,6 @@ static int ad7816_probe(struct spi_device *spi_dev)
 
 	indio_dev->name = spi_get_device_id(spi_dev)->name;
 	indio_dev->info = &ad7816_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (spi_dev->irq) {
 		/* Only low trigger is supported in ad7816/7/8 */
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index ccbafcaaf27e..d51882ff73fd 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2176,7 +2176,6 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	else
 		indio_dev->info = &adt7316_info;
 	indio_dev->name = name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (chip->bus.irq > 0) {
 		ret = adt7316_setup_irq(indio_dev);
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 48132ab157ef..15710dcfe62c 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -593,8 +593,6 @@ static int ad7150_probe(struct i2c_client *client,
 
 	indio_dev->info = &ad7150_info;
 
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL,
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index dfd71e99e872..9f97e43b399f 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -701,7 +701,6 @@ static int ad7746_probe(struct i2c_client *client,
 	else
 		indio_dev->num_channels =  ARRAY_SIZE(ad7746_channels) - 2;
 	indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (pdata) {
 		if (pdata->exca_en) {
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 447937e04ebd..77ed624ca9fc 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -350,7 +350,6 @@ static int ad9832_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9832_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default messages */
 
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 262c3590e64e..75b85c0e2b30 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -440,7 +440,6 @@ static int ad9834_probe(struct spi_device *spi)
 		indio_dev->info = &ad9834_info;
 		break;
 	}
-	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default messages */
 
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 74adb82f37c3..f47acccabaef 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -672,7 +672,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
 	indio_dev->info = &ad2s1210_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1210_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
-- 
2.27.0

